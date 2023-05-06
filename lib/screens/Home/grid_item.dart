import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/Constants.dart';

class GridItem extends StatelessWidget {
  final String status;
  final String time;
  final String value;
  final String unit;
  final String? image;
  final Color color;
  final String remarks;

  GridItem({
    Key? key,
    required this.status,
    required this.value,
    required this.unit,
    required this.time,
    this.image,
    required this.remarks,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  status,
                  style: TextStyle(fontSize: 12, color: Constants.textPrimary),
                ),
                Text(
                  time,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            if (image == null)
              Column(
                children: <Widget>[
                  Text(
                    value,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                        color: color),
                  ),
                  Text(
                    unit,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image.asset(image!),
                  Text(
                    remarks,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
