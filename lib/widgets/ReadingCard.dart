import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

Card ReadingCard(String value, String time) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value, textAlign: TextAlign.center, style: AppTheme.bodyBlackMd),
        Text(time)
      ],
    ),
  );
}
