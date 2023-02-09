// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/screens/Authentication/SignInScreen.dart';
import 'package:insulin_pump/screens/mediterranesn_diet_view.dart';
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
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
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
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  // Padding(
                  //   padding: const EdgeInsets.all(AppTheme.defaultPadding),
                  //   child: const Text(
                  //     "Last reading was",
                  //     style: AppTheme.bodyWhiteLg,
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppTheme.defaultPadding),
                    child: const LastReadingCircle(
                      lastReadingValue: 350,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: AppTheme.defaultPadding),
                    child: Button(context, "Inject", () {
                      setState(() {
                        print(max);
                        max++;
                      });
                    }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
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
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        GeneralCard(
                          text: "min sugar level",
                          value: 80,
                          color: AppTheme.darkYellowColor,
                        ),
                        GeneralCard(
                          text: "he",
                          value: 50,
                          color: AppTheme.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              )

              // Container(
              //   child: Padding(
              //     padding: const EdgeInsets.all(AppTheme.defaultPadding * 2),
              //     child: Container(
              //       alignment: Alignment.topCenter,
              //       child: ElevatedButton(
              //         child: Text("Logout"),
              //         onPressed: () {
              //           FirebaseAuth.instance.signOut().then((value) {
              //             print("Signed Out");
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => SignInScreen()));
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),

              ),
          // Expanded(child: GeneralCard())
        ],
      ),

      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(AppTheme.defaultPadding * 2),
      //       child: Container(
      //         height: 250,
      //         decoration: BoxDecoration(
      //           color: AppTheme.white,
      //           borderRadius: const BorderRadius.only(
      //               topLeft: Radius.circular(68.0),
      //               bottomLeft: Radius.circular(8.0),
      //               bottomRight: Radius.circular(68.0),
      //               topRight: Radius.circular(8.0)),
      //           boxShadow: <BoxShadow>[
      //             BoxShadow(
      //                 color: AppTheme.grey.withOpacity(0.5),
      //                 offset: const Offset(1.1, 1.1),
      //                 blurRadius: 10.0),
      //           ],
      //         ),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           // ignore: prefer_const_literals_to_create_immutables
      //           children: [
      //             const Text(
      //               "Last reading was:",
      //               style: AppTheme.bodyPrimaryLg,
      //             ),
      //             const LastReadingCircle(
      //               lastReadingValue: 250,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
