import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Constants.dart';

class ProgressVertical extends StatelessWidget {
  final int value;
  final String date;
  final bool isShowDate;

  ProgressVertical(
      {Key? key,
      required this.value,
      required this.date,
      required this.isShowDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 7),
        width: 30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                width: 10,
                // ignore: unnecessary_new
                decoration: new BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                  shape: BoxShape.rectangle,
                  color: AppTheme.primaryColorLight,
                ),
                // ignore: unnecessary_new
                child: new LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          // ignore: unnecessary_new
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            shape: BoxShape.rectangle,
                            color: AppTheme.primaryColor,
                          ),
                          height: constraints.maxHeight * (value / 100),
                          width: constraints.maxWidth,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 10),
            Text((isShowDate) ? date : ""),
          ],
        ));
  }
}
