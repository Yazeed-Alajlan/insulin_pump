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
  String lastValue = "0";
  String average = "0";

  static DateTime selectedDate = DateTime.now();
  final Query<Map<String, dynamic>> _collectionRef = FirebaseFirestore.instance
      .collection('Records')
      .where("Date", isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate));

  Future<Iterable<double>> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => double.parse(doc["value"]));
    return allData;
  }

  void addData() {
    FirebaseFirestore.instance
        .collection('Records')
        .add({"Value": 40, "Date": "2023-04-29", "createdAt": DateTime.now()});
  }

  @override
  void initState() {
    super.initState();
    changeCardsValues();
  }

  void changeCardsValues() async {
    var values = await getData();
    var largest = values.first;
    var smallest = values.first;
    var sum = 0.0;
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
      lastValue = values.last.toString();
      average = (sum / values.length).toStringAsFixed(1);
      // last =  values.last.toString();

//       FirebaseFirestore.instance
// .collection('Records').orderBy("createdAt", descending: true).limit(1);
    });
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
    const itemsSize = 70.0;
    const animationDurationInMs = Duration(milliseconds: 250);

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: ListView(
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
                              style: AppTheme.bodyWhite(size: "lg", bold: true),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                if (globals.device != null &&
                                    globals.read != null)
                                  StreamBuilder<List<int>>(
                                      stream: globals.read!.value,
                                      initialData: globals.read!.lastValue,
                                      builder: (context, snapshot) {
                                        var value = snapshot.data;
                                        var lastreading =
                                            utf8.decode(value!).toString();
                                        // print(lastreading);
                                        // if (double.tryParse(lastreading)! >=
                                        //     100) {
                                        //   // widget.write.write(utf8.encode("3"));
                                        // }
                                        globals.read!.read();
                                        return Text(
                                          lastValue,
                                          // utf8.decode(value!),
                                          style:
                                              AppTheme.bodyWhite(size: "xlg"),
                                        );
                                      }),
                                if (globals.device == null ||
                                    globals.read == null)
                                  Text(
                                    lastValue,
                                    // utf8.decode(value!),
                                    style: AppTheme.bodyWhite(size: "xlg"),
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
                                  image: AssetImage('assets/icons/syringe.png'),
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
                        shadowColor: Colors.grey.withOpacity(0.01), // added
                        type: MaterialType.card,
                        elevation: 10,
                        borderRadius: new BorderRadius.circular(16.0),
                        child: Container(
                          padding:
                              const EdgeInsets.all(AppTheme.defaultPadding),
                          height: 300,
                          child: Column(
                            children: <Widget>[
                              // Rest Active Legend
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        color: AppTheme.primaryColorLight,
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
                        padding: EdgeInsets.all(AppTheme.defaultPadding),
                        shrinkWrap: true,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  value: average,
                                  unit: "avg bpm",
                                  color: AppTheme.successColor,
                                  image: null,
                                  remarks: "ok");
                            case 1:
                              return GridItem(
                                  status: "Mamximum",
                                  time: "",
                                  value: max,
                                  unit: "avg bpm",
                                  color: AppTheme.dangerColor,
                                  image: null,
                                  remarks: "ok");
                            case 2:
                              return GridItem(
                                  status: "Minuimum",
                                  time: "",
                                  value: min,
                                  unit: "avg bpm",
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
      ),
    );
    ;
  }
}
