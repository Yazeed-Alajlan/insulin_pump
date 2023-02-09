import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

Widget ReadingCard(String value, String time) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value, textAlign: TextAlign.center, style: AppTheme.bodyBlackMd),
        Text("8:26 AM")
      ],
    ),
  );
}
