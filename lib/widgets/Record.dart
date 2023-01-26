// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

class Record extends StatelessWidget {
  const Record({
    super.key,
    required this.date,
    required this.value,
  });
  final String value;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8, top: 16),
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: -0.1,
                            color: AppTheme.darkText),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 3),
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color: AppTheme.nearlyDarkBlue,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                'sugar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  letterSpacing: -0.2,
                                  color: AppTheme.nearlyDarkBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: AppTheme.grey.withOpacity(0.5),
                                  size: 16,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Today 8:26 AM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      color: AppTheme.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 4, bottom: 14),
                              child: Text(
                                'InBody SmartScale',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                  color: AppTheme.nearlyDarkBlue,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 24, right: 24, top: 8, bottom: 8),
              //   child: Container(
              //     height: 2,
              //     decoration: const BoxDecoration(
              //       color: AppTheme.background,
              //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 24, right: 24, top: 8, bottom: 16),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             const Text(
              //               '185 cm',
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                 fontFamily: AppTheme.fontName,
              //                 fontWeight: FontWeight.w500,
              //                 fontSize: 16,
              //                 letterSpacing: -0.2,
              //                 color: AppTheme.darkText,
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(top: 6),
              //               child: Text(
              //                 'Height',
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                   fontFamily: AppTheme.fontName,
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 12,
              //                   color: AppTheme.grey.withOpacity(0.5),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: <Widget>[
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 const Text(
              //                   '27.3 BMI',
              //                   textAlign: TextAlign.center,
              //                   style: TextStyle(
              //                     fontFamily: AppTheme.fontName,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 16,
              //                     letterSpacing: -0.2,
              //                     color: AppTheme.darkText,
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 6),
              //                   child: Text(
              //                     'Overweight',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       fontFamily: AppTheme.fontName,
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 12,
              //                       color: AppTheme.grey.withOpacity(0.5),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: <Widget>[
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: <Widget>[
              //                 const Text(
              //                   '20%',
              //                   style: TextStyle(
              //                     fontFamily: AppTheme.fontName,
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 16,
              //                     letterSpacing: -0.2,
              //                     color: AppTheme.darkText,
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 6),
              //                   child: Text(
              //                     'Body fat',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       fontFamily: AppTheme.fontName,
              //                       fontWeight: FontWeight.w600,
              //                       fontSize: 12,
              //                       color: AppTheme.grey.withOpacity(0.5),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
