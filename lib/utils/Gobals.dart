library globals;

import 'package:flutter_blue/flutter_blue.dart';

BluetoothDevice? device;
BluetoothCharacteristic? read;
BluetoothCharacteristic? write;

String lastReading = "0";
double counter = 0;
