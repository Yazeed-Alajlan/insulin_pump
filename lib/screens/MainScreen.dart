import 'package:insulin_pump/screens/History/HistoryScreen.dart';
import 'package:insulin_pump/screens/Injection/InjectionScreen.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/TabIconData.dart';
import 'package:insulin_pump/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    for (final TabIconData tab in tabIconsList) {
      tab.isSelected = false;
    }
    // tabIconsList[0].isSelected = true;
    tabBody = InjectionScreen(animationController: animationController);
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
                      InjectionScreen(animationController: animationController);
                });
              }
              return;
            });
          },
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody =
                        HistoryScreen(animationController: animationController);
                  });
                }
                return;
              });
            } else if (index == 1 || index == 3) {
              animationController.reverse().then<dynamic>((_) {
                if (mounted) {
                  setState(() {
                    tabBody =
                        HistoryScreen(animationController: animationController);
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
