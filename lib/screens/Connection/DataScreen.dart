import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/screens/MainScreen.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  void discoverServices() async {
    List<BluetoothService> services = await globals.device!.discoverServices();
    late BluetoothCharacteristic read, write;
    if (globals.read == null || globals.write == null) {
      print(
          "----------------------------------------discoverServices----------------------------------------------");
      services.forEach((service) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() ==
              "7def8317-7301-4ee6-8849-46face74ca2a")
            globals.read = characteristic;
          if (characteristic.uuid.toString() ==
              "7def8317-7302-4ee6-8849-46face74ca2a")
            globals.write = characteristic;
        });
      });
    }
  }

  void addData() {
    if (globals.lastReading != "0") {
      FirebaseFirestore.instance.collection('Records').add({
        "Value": utf8.decode(globals.read!.lastValue).toString(),
        "Date": "2023-05-07",
        "createdAt": DateTime.now()
      });
    }
  }

  @override
  void initState() {
    discoverServices();
  }

  @override
  Widget build(BuildContext context) {
    discoverServices();

    const counter = const Duration(seconds: 15);
    Timer.periodic(
        counter,
        (Timer t) => {
              discoverServices(),
              globals.lastReading = globals.read!.read().toString(),
              addData(),
              print(
                  "---------------------------------------------------DATA---------------------------------------------------"),
            });
    return MainScreen();
  }
}
