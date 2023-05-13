import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/screens/MainScreen.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;
import 'package:intl/intl.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({required this.device, super.key});

  final BluetoothDevice? device;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  void discoverServices() async {
    print(
        "----------------------------------------discoverServices----------------------------------------------");
    print(widget.device);
    List<BluetoothService> services = await widget.device!.discoverServices();
    if (globals.read == null || globals.write == null) {
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
  }

  void addData() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    if (globals.lastReading != "0" ||
        globals.lastReading != "" ||
        globals.read!.lastValue != "") {
      FirebaseFirestore.instance.collection('Records').add({
        "Value": utf8.decode(globals.read!.lastValue).toString(),
        "Date": formattedDate,
        "createdAt": now
      });
    }
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (globals.read == null) {
        discoverServices();
        timer.cancel();
      }
    });
    Timer.periodic(Duration(seconds: 4), (timer) async {
      if (globals.read == null) discoverServices();

      if (globals.read != null || globals.read != "") {
        // Read data from the characteristic
        await globals.read!.read();

        // Handle the received data here
        List<int> value = await globals.read!.read();
        print('Received data:');
        print(utf8.decode(value).toString());
        double valueInDouble = double.parse(utf8.decode(value).toString());

        if (valueInDouble > 200.0) globals.write!.write(utf8.encode("2"));
        if (valueInDouble < 60.0) globals.write!.write(utf8.encode("3"));

        setState(() {
          globals.lastReading = utf8.decode(value).toString();
        });
        addData();
      }
    });
    discoverServices();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
