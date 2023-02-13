import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

Widget ReadingCard(String value, String time) {
  return Container(
    height: 85,
    child: Padding(
      padding: const EdgeInsets.all(AppTheme.defaultPadding + 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, textAlign: TextAlign.center, style: AppTheme.bodyBlackLg),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppTheme.grey.withOpacity(0.5),
                size: 16,
              ),
              Text(
                time,
                style: AppTheme.bodyBlackMd,
              )
            ],
          ),
        ],
      ),
    ),
  );
}
