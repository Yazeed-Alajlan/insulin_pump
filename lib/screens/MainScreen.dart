import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/screens/Connection/Connection.dart';
import 'package:insulin_pump/screens/History/HistoryScreen.dart';
import 'package:insulin_pump/screens/Home/HomeScreen.dart';
import 'package:insulin_pump/screens/Injection/InjectionScreen.dart';
import 'package:insulin_pump/screens/Settings/SettingsScreen.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/TabIconData.dart';
import 'package:insulin_pump/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  late final AnimationController animationController;

  // Future<List<BluetoothCharacteristic>> discoverServices() async {
  //   List<BluetoothService> services = await globals.device!.discoverServices();
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

  @override
  void initState() {
    super.initState();
    for (final TabIconData tab in tabIconsList) {
      tab.isSelected = false;
    }
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    // discoverServices();
    tabBody = HomeScreen(animationController: animationController);

    // tabIconsList[0].isSelected = true;
    // tabBody = InjectionScreen(
    //   animationController: animationController,
    //   device: widget.device,
    // );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.background,
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Stack(
              children: <Widget>[
                tabBody,
                bottomBar(),
              ],
            );
          }
        },
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomNavigation(
          tabIconsList: tabIconsList,
          addClick: () {
            animationController.reverse().then<dynamic>((_) {
              if (mounted) {
                setState(() {
                  tabBody =
                      HomeScreen(animationController: animationController);
                });
              }
              return;
            });
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody =
                        HistoryScreen(animationController: animationController);
                  });
                }
                return;
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = ConnectionScreen();
                  });
                }
                return;
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = InjectionScreen();
                  });
                }

                return;
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody = SettingsScreen(
                        animationController: animationController);
                  });
                }
                return;
              });
            } else {
              for (final TabIconData tab in tabIconsList) {
                tab.isSelected = false;
              }
            }
          },
        ),
      ],
    );
  }
}
