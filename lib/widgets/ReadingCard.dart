import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

Widget ReadingCard(String value, String time) {
  return Container(
    height: 85,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: AppTheme.darkGrey.withOpacity(0.6), width: 1))),
    child: Padding(
      padding: const EdgeInsets.all(AppTheme.defaultPadding + 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value,
              textAlign: TextAlign.center,
              style: AppTheme.bodyBlack(size: "lg")),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.access_time,
                  color: AppTheme.grey.withOpacity(0.6),
                  size: 20,
                ),
              ),
              Text(
                "08:00 AM",
                style: AppTheme.bodyBlack(size: "md"),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
