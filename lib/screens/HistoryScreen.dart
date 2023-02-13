import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/CustomBackground.dart';
import 'package:insulin_pump/widgets/ReadingCard.dart';
import 'package:insulin_pump/widgets/Record.dart';
import 'dart:math';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    required this.animationController,
    super.key,
  });
  final AnimationController animationController;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? selectedDate;
  Random random = new Random();

  @override
  void initState() {
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        accent: AppTheme.primaryColor,
        backButton: false,
        onDateChanged: (value) => setState(() => selectedDate = value),
        lastDate: DateTime.now(),
        // events: List.generate(
        //     100,
        //     (index) => DateTime.now()
        //         .subtract(Duration(days: index * random.nextInt(5)))),
      ),
      extendBodyBehindAppBar: true,
      body: CustomPaint(
        // painter: CustomBackground(),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Records') // 👈 Your desired collection name here
                .where("Date",
                    isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate!))
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return ListView(
                  // itemExtent: 100.0,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ReadingCard(data['value'], data['Date']);
              }).toList());
            },
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //         child: FutureBuilder<QuerySnapshot>(
  //       future: FirebaseFirestore.instance
  //           .collection('Records') // 👈 Your collection name here
  //           .get(),
  //       builder: (_, snapshot) {
  //         if (snapshot.hasError) return Text('Error = ${snapshot.error}');
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Text("Loading");
  //         }
  //         return ListView(
  //             children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //           Map<String, dynamic> data =
  //               document.data()! as Map<String, dynamic>;
  //           return ListTile(
  //             title: Text(data['value']), // 👈 Your valid data here
  //           );
  //         }).toList());
  //       },
  //     )),
  //   );
  // }
}
