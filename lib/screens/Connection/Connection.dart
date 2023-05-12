import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/screens/Connection/DataScreen.dart';
import 'package:insulin_pump/screens/Connection/widgets.dart';
import 'package:insulin_pump/screens/MainScreen.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;
import 'package:insulin_pump/widgets/CustomAppBar.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({
    super.key,
  });
  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final Future<bool> _future = Future.delayed(Duration(seconds: 3), () => true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return FindDevicesScreen();
          }
          return BluetoothOffScreen(state: state);
        });
  }
}

// Widget build(BuildContext context) {
//   return FutureBuilder(
//     future: _future,
//     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else {
//         return StreamBuilder<BluetoothState>(
//             stream: FlutterBlue.instance.state,
//             initialData: BluetoothState.unknown,
//             builder: (c, snapshot) {
//               final state = snapshot.data;
//               if (state == BluetoothState.on) {
//                 return FindDevicesScreen();
//               }
//               return BluetoothOffScreen(state: state);
//             });
//       }
//     },
//   );
// }

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  // Future<List<BluetoothCharacteristic>> discoverServices(
  //     BluetoothDevice device) async {
  //   List<BluetoothService> services = await device.discoverServices();
  //   late BluetoothCharacteristic read, write;
  //   services.forEach((service) {
  //     service.characteristics.forEach((characteristic) {
  //       if (characteristic.uuid.toString() ==
  //           "7def8317-7301-4ee6-8849-46face74ca2a") read = characteristic;
  //       if (characteristic.uuid.toString() ==
  //           "7def8317-7302-4ee6-8849-46face74ca2a") write = characteristic;
  //     });
  //   });
  //   return [read, write];
  // }
  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await globals.device!.discoverServices();

    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        if (characteristic.uuid.toString() ==
            "7def8317-7301-4ee6-8849-46face74ca2a") {
          globals.read = characteristic;
        }
        if (characteristic.uuid.toString() ==
            "7def8317-7302-4ee6-8849-46face74ca2a")
          globals.write = characteristic;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Find Devices",
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  // CHECK NAME
                  children: snapshot.data!
                      .where((d) => d.name == "BLE_String")
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                        BluetoothDeviceState.connected &&
                                    globals.device == null) {
                                  globals.device = d;
                                  return ElevatedButton(
                                      child: Text('OPEN'),
                                      onPressed: () => {
                                            discoverServices(d),
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DataScreen(
                                                              device: d,
                                                            ))),
                                          });
                                }
                                // return Text(snapshot.data.toString());
                                return Text("Device is connected");
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              if (globals.device == null)
                StreamBuilder<List<ScanResult>>(
                  stream: FlutterBlue.instance.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!
                        .where((r) => r.device.name == "BLE_String")
                        .map(
                          (r) => ScanResultTile(
                              result: r,
                              onTap: () => {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      r.device.connect();
                                      globals.device = r.device;
                                      discoverServices(r.device);
                                      return DataScreen(device: r.device);
                                    })),
                                  }),
                        )
                        .toList(),
                  ),
                ),
              SizedBox(height: 300),
              if (globals.device == null)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.nearlyDarkBlue,
                      gradient: const LinearGradient(colors: <Color>[
                        AppTheme.nearlyDarkBlue,
                        Color(0xFF6A88E5),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        globals.device = null;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        );
                      },
                      child: Text('Continue Without Connection'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 64),
        child: StreamBuilder<bool>(
          stream: FlutterBlue.instance.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data!) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => FlutterBlue.instance.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyDarkBlue,
                  gradient: const LinearGradient(colors: <Color>[
                    AppTheme.nearlyDarkBlue,
                    Color(0xFF6A88E5),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  shape: BoxShape.circle,
                ),
                child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.search),
                    onPressed: () => FlutterBlue.instance
                        .startScan(timeout: Duration(seconds: 4))),
              );
            }
          },
        ),
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [1, 1, 1, 1];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .where((s) => s.uuid.toString().toUpperCase().substring(4, 8) == "8317")
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(_getRandomBytes());
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
