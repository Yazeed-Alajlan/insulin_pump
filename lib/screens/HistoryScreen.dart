import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Records') // 👈 Your desired collection name here
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
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['Date']), // 👈 Your valid data here
              );
            }).toList());
          },
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
