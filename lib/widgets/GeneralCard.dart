// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/widgets/ReadingCard.dart';

class GeneralCard extends StatefulWidget {
  final double value;
  final String text;
  final Color color;
  const GeneralCard(
      {Key? key, required this.value, required this.text, required this.color})
      : super(key: key);

  @override
  State<GeneralCard> createState() => _GeneralCardState();
}

class _GeneralCardState extends State<GeneralCard> {
  double value = 0;
  String text = "";
  Color color = Color(0xFFFFFFFF);
  @override
  void initState() {
    value = widget.value;
    text = widget.text;
    color = widget.color;
    print("helllllllllllo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.defaultPadding - 2),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          // color: this.color,
          color: AppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0),
              topRight: Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 120.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.value}",
              style: AppTheme.body(size: 32, color: this.color),
            ),
            Text(
              this.text,
              style: AppTheme.body(size: 18, color: this.color),
            )
          ],
        ),
      ),
    );
  }
}
