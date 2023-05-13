import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;
import 'package:insulin_pump/widgets/CustomAppBar.dart';
import 'package:intl/intl.dart';

class InjectionScreen extends StatefulWidget {
  const InjectionScreen({
    super.key,
  });
  @override
  State<InjectionScreen> createState() => _InjectionScreenState();
}

class _InjectionScreenState extends State<InjectionScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<bool> canInject() async {
    DateTime now = DateTime.now().subtract(Duration(hours: 2));
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Injections')
        .where("injectedAt",
            isGreaterThan: DateFormat('yyyy-MM-dd HH:mm').format(now))
        .get();
    List values = snapshot.docs.map((doc) => doc.data()).toList();
    return values.isNotEmpty;
  }

  void addData() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    FirebaseFirestore.instance
        .collection('Injections')
        .add({"injectedAt": formattedDate});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Inject",
      ),
      body: Container(
        height: 400,
        child: Center(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      style: TextStyle(color: Colors.red),
                      controller: _controller,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppTheme.primaryColor),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: AppTheme.primaryColor),
                          ),
                          labelText: 'Enter Carbs (grams)',
                          labelStyle:
                              AppTheme.bodyBlack(size: "sm", bold: true)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
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
                      onPressed: () async {
                        var injectionFlag = await canInject();
                        if (injectionFlag) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'You need to wait 2 hours from the last injection'),
                            ),
                          );
                        } else {
                          int value = int.tryParse(_controller.text) ?? 0;
                          if (value < 1 || value > 255) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Carbs value must be between 1 and 255'),
                              ),
                            );
                          } else {
                            try {
                              String hexString = value.toRadixString(16);
                              if (hexString.length == 1)
                                hexString = "10" + hexString;
                              else
                                hexString = "1" + hexString;
                              globals.write!.write(utf8.encode(hexString));
                              addData();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Device is not connected. Or check again later'),
                                ),
                              );
                            }
                          }

                          _controller.clear();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Text(
                          'Inject',
                          style: AppTheme.bodyWhite(size: "md"),
                        ),
                      ),
                    ),
                  ),
                  Text(globals.read.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
