import 'package:insulin_pump/screens/Authentication/SignInScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication/SignInScreen.dart';
import 'Authentication/SignUpScreen.dart';
import '../utils/AppTheme.dart';
import '../utils/TabIconData.dart';
import '../widgets/BottomNavigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: Colors.red,
  );

  late final AnimationController animationController;
  @override
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BottomNavigation(
            tabIconsList: tabIconsList,
            addClick: () {},
            changeIndex: (int index) {
              if (index == 0 || index == 2) {
                animationController.reverse().then<dynamic>((_) {
                  if (mounted) {
                    setState(() {
                      tabBody = SignInScreen();
                    });
                  }
                  return;
                });
              } else if (index == 1 || index == 3) {
                animationController.reverse().then<dynamic>((_) {
                  if (mounted) {
                    setState(() {
                      tabBody = SignInScreen();
                    });
                  }
                  return;
                });
              }
            },
          ),
          Center(
            child: ElevatedButton(
              child: Text("Logout"),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
