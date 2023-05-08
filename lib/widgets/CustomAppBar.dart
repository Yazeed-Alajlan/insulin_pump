import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      padding: EdgeInsets.only(bottom: 6.0),
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            gradient: const LinearGradient(colors: <Color>[
              AppTheme.nearlyDarkBlue,
              Color(0xFF6A88E5),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(64.0),
              bottomRight: Radius.circular(64.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(.4),
                  spreadRadius: 2.0,
                  blurRadius: 12.0)
            ]),
        child: Center(
          child: Text(
            text,
            style: AppTheme.headerMd,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 150.0);
}
