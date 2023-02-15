import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/screens/Authentication/SignInScreen.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/widgets/Button.dart';
import 'package:insulin_pump/widgets/GeneralCard.dart';
import 'package:insulin_pump/widgets/LastReadingCircle.dart';

class InjectionScreen extends StatefulWidget {
  const InjectionScreen({
    required this.animationController,
    super.key,
  });
  final AnimationController animationController;

  @override
  State<InjectionScreen> createState() => _InjectionScreenState();
}

class _InjectionScreenState extends State<InjectionScreen> {
  double max = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(140),
                bottomLeft: Radius.circular(140),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(offset: const Offset(1, 1), blurRadius: 20.0),
              ],
              color: AppTheme.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LastReadingCircle(
                  lastReadingValue: 250,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: AppTheme.defaultPadding * 2),
                  child: Button(context, "Inject", () {
                    setState(() {
                      max++;
                    });
                  }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GeneralCard(
                      text: "avg sugar level",
                      value: 90,
                      color: AppTheme.darkGreenColor,
                    ),
                    GeneralCard(
                      text: "max sugar level",
                      value: max,
                      color: AppTheme.dangerColor,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const GeneralCard(
                      text: "he",
                      value: 50,
                      color: AppTheme.grey,
                    ),
                    GeneralCard(
                      text: "min sugar level",
                      value: 80,
                      color: AppTheme.darkYellowColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Container(
              height: 500,
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
