import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Constants.dart';
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
      backgroundColor: Constants.backgroundColor,
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
                .orderBy("createdAt", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong, check again later');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading data");
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 62),
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ReadingCard(data['Value'], data['createdAt']);
                    }).toList()),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget ReadingCard(String value, Timestamp time) {
  DateTime dateTime = time.toDate();
  String formattedTime = DateFormat('HH:mm').format(dateTime);

  return Padding(
    padding: const EdgeInsets.all(AppTheme.defaultPadding),
    child: Material(
      shadowColor: Colors.grey.withOpacity(0.001), // added
      type: MaterialType.card,
      elevation: 5,
      borderRadius: new BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
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
                  formattedTime,
                  style: AppTheme.bodyBlack(size: "md"),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
