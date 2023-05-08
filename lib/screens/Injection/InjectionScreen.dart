import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;
import 'package:insulin_pump/widgets/CustomAppBar.dart';

class InjectionScreen extends StatefulWidget {
  const InjectionScreen({
    super.key,
  });
  @override
  State<InjectionScreen> createState() => _InjectionScreenState();
}

class _InjectionScreenState extends State<InjectionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool flag = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (globals.device == null) {
      flag = true;
    }
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
                      onPressed: () {
                        double value = double.tryParse(_controller.text) ?? 0.0;
                        globals.write!.write(utf8.encode(value.toString()));
                        _controller.clear();
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
                  Text(flag ? "yes" : "no"),
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
