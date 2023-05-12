import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insulin_pump/screens/Home/custom_clipper.dart';
import 'package:insulin_pump/screens/Home/grid_item.dart';
import 'package:insulin_pump/screens/Home/progress_vertical.dart';
import 'package:insulin_pump/utils/AppTheme.dart';
import 'package:insulin_pump/utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:insulin_pump/utils/Gobals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.animationController,
    super.key,
  });
  final AnimationController animationController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String max = "0";
  String min = "0";
  String average = "0";
  String lastValue = "0";

  static DateTime selectedDate = DateTime.now();
  final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
      .collection('Records')
      .where("Date", isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate));

  Future<Iterable<double>> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => double.parse(doc["Value"]));
    return allData;
  }

  void getLastData() async {
    Query query = FirebaseFirestore.instance
        .collection("Records")
        .where("Date", isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
        .orderBy("createdAt", descending: true)
        .limit(1);

    query.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Do something with the last data added
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        var snapshot = documentSnapshot.data() as Map;
        globals.lastReading = snapshot["Value"];
      }
    });

    // QuerySnapshot querySnapshot =
    //     await _collectionRef.get();
    // final allData = querySnapshot.docs
    //     .map((doc) => {double.parse(doc["Value"]), doc["createdAt"]});
    // return allData;

    // return FirebaseFirestore.instance
    //     .collection('Records')
    //     .orderBy("createdAt", descending: true)
    //     .limit(1)
    //     .toString();
    // ;
  }

  @override
  void initState() {
    super.initState();
    // changeCardsValues();
  }

  void changeCardsValues() async {
    var values = await getData();
    getLastData();
    print(values);
    var largest = 0.0;
    var smallest = 0.0;
    var sum = 0.0;
    if (values.isNotEmpty) {
      largest = values.first;
      smallest = values.first;
      for (var i = 0; i < values.length; i++) {
        sum = sum + values.elementAt(i);
        // Checking for largest value in the list
        if (values.elementAt(i) > largest) {
          largest = values.elementAt(i);
        }

        // Checking for smallest value in the list
        if (values.elementAt(i) < smallest) {
          smallest = values.elementAt(i);
        }
      }
      setState(() {
        max = largest.toString();
        min = smallest.toString();
        // globals.lastReading = values.last.toString();

        average = (sum / values.length).toStringAsFixed(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // For Grid Layout
    double crossAxisSpacing = 16, mainAxisSpacing = 16, _cellHeight = 150.0;
    int crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    double aspectRatio =
        _width / (_cellHeight + mainAxisSpacing + (crossAxisCount + 1));

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Records')
              .where("Date",
                  isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
              .orderBy("createdAt", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong, check again later');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // return const Text('Loading');
              return Center(child: CircularProgressIndicator());
            } else {
              var allData =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return data;
              }).toList();
              double max = 0, min = 0, sum = 0, average = 0;
              String lastReading = "0";
              if (allData.isNotEmpty) {
                max = allData
                    .map((object) => double.parse(object["Value"]))
                    .reduce(
                        (value, element) => value > element ? value : element);

                min = allData
                    .map((object) => double.parse(object["Value"]))
                    .reduce(
                        (value, element) => value < element ? value : element);

                sum = allData
                    .map((object) => double.parse(object["Value"]))
                    .reduce((value, element) => value + element);
                average = sum / allData.length;

                lastReading = allData.first["Value"];
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Stack(
                    children: [
                      ClipPath(
                        clipper: MyCustomClipper(clipType: ClipType.bottom),
                        child: Container(
                          height: Constants.headerHeight + statusBarHeight,
                          decoration: AppTheme.primaryColorGradient,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: statusBarHeight,
                            bottom: AppTheme.defaultPadding,
                            right: AppTheme.defaultPadding,
                            left: AppTheme.defaultPadding),
                        child: Column(
                          children: [
                            // ----------TOP----------//
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Blood Sugar",
                                      style: AppTheme.bodyWhite(
                                          size: "lg", bold: true),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        Text(
                                          lastReading,
                                          style:
                                              AppTheme.bodyWhite(size: "xlg"),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "mg/dL",
                                          style: AppTheme.bodyWhite(size: "md"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                ClipOval(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.1),
                                    height: 150,
                                    width: 150,
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/icons/syringe.png'),
                                          fit: BoxFit.cover,
                                          color: Colors.white.withOpacity(0.8)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ----------Chart----------//
                            Padding(
                              padding: const EdgeInsets.all(
                                AppTheme.defaultPadding,
                              ),
                              child: Material(
                                shadowColor:
                                    Colors.grey.withOpacity(0.01), // added
                                type: MaterialType.card,
                                elevation: 10,
                                borderRadius: new BorderRadius.circular(16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      AppTheme.defaultPadding),
                                  height: 300,
                                  child: Column(
                                    children: <Widget>[
                                      // Rest Active Legend
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.all(10.0),
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                color: AppTheme.primaryColor,
                                                shape: BoxShape.circle),
                                          ),
                                          Text("Daily Readings"),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      // Main Cards - Heartbeat and Blood Pressure
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            AppTheme.defaultPadding),
                                        child: Container(
                                          height: 100,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: <Widget>[
                                              ProgressVertical(
                                                value: 50,
                                                date: "5/11",
                                                isShowDate: true,
                                              ),
                                              ProgressVertical(
                                                value: 50,
                                                date: "5/12",
                                                isShowDate: false,
                                              ),
                                              ProgressVertical(
                                                value: 45,
                                                date: "5/13",
                                                isShowDate: false,
                                              ),
                                              ProgressVertical(
                                                value: 30,
                                                date: "5/14",
                                                isShowDate: true,
                                              ),
                                              ProgressVertical(
                                                value: 50,
                                                date: "5/15",
                                                isShowDate: false,
                                              ),
                                              ProgressVertical(
                                                value: 20,
                                                date: "5/16",
                                                isShowDate: false,
                                              ),
                                              ProgressVertical(
                                                value: 45,
                                                date: "5/17",
                                                isShowDate: true,
                                              ),
                                              ProgressVertical(
                                                value: 67,
                                                date: "5/18",
                                                isShowDate: false,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      // Line Graph
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              shape: BoxShape.rectangle,
                                              color: AppTheme.primaryColor,
                                            ),
                                            child: ClipPath(
                                              clipper: MyCustomClipper(
                                                  clipType: ClipType.multiple),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                                shape: BoxShape.rectangle,
                                                color:
                                                    AppTheme.primaryColorLight,
                                              )),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // ----------Cards----------//
                            Container(
                              // ignore: unnecessary_new
                              child: new GridView.builder(
                                padding:
                                    EdgeInsets.all(AppTheme.defaultPadding),
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: crossAxisSpacing,
                                  mainAxisSpacing: mainAxisSpacing,
                                  childAspectRatio: aspectRatio,
                                ),
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int index) {
                                  switch (index) {
                                    case 0:
                                      return GridItem(
                                          status: "Average",
                                          time: "",
                                          value: average.toStringAsFixed(1),
                                          unit: "",
                                          color: AppTheme.successColor,
                                          image: null,
                                          remarks: "ok");
                                    case 1:
                                      return GridItem(
                                          status: "Mamximum",
                                          time: "",
                                          value: max.toString(),
                                          unit: "",
                                          color: AppTheme.dangerColor,
                                          image: null,
                                          remarks: "ok");
                                    case 2:
                                      return GridItem(
                                          status: "Minuimum",
                                          time: "",
                                          value: min.toString(),
                                          unit: "",
                                          color: AppTheme.warningColor,
                                          image: null,
                                          remarks: "Fit");
                                    case 3:
                                      return GridItem(
                                          status: "Number of Injects",
                                          time: "",
                                          value: "",
                                          unit: "",
                                          color: Constants.darkOrange,
                                          image: "assets/icons/syringe.png",
                                          remarks: "10");
                                    // default:
                                    //   return GridItem(
                                    //     status: "Rest",
                                    //     time: "4h 45m",
                                    //     value: "76",
                                    //     unit: "avg bpm",
                                    //     image: null,
                                    //     remarks: "ok",
                                    //     color: Constants.darkOrange,
                                    //   );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          }),
    );
    ;
  }
}
