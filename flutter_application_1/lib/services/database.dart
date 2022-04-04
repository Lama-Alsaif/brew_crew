import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection refrence
  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection(
          'brews'); //Change the name from 'Firestore' to 'FirebaseFirestore'.

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }
  //get brews stream

  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}
