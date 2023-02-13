// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/widgets/ReadingCard.dart';

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
    // return Card(
    //   child: Padding(
    //     padding: EdgeInsets.only(top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
    //     child: ExpansionTile(
    //       title: Text(date),
    //       children: <Widget>[
    //         Text(value),
    //         Text(value),
    //         Text(value),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultPadding - 4),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.3),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.defaultPadding - 2),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                // ignore: sort_child_properties_last
                children: <Widget>[
                  ReadingCard(value, "105"),
                ],
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 4, bottom: 3),
                              child: Text(date,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.bodyPrimaryLg),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: AppTheme.grey.withOpacity(0.5),
                              size: 16,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
