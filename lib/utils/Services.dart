import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  final CollectionReference profilelist =
      FirebaseFirestore.instance.collection('Records');

  Future getUsersList() async {
    List itemsList = [];
    try {
      await profilelist.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
