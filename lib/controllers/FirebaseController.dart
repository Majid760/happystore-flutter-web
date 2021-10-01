import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  static final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore get db_instance => _db;

  FirebaseAuth get db_auth => _auth;

  FirebaseController();

  // get product stream from firebase
  Stream<QuerySnapshot<Map<String, dynamic>>> get products_stream {
    return FirebaseController.firestoreInstance
        .collection('products')
        .snapshots(includeMetadataChanges: true);
  }

  // get products once

  Future getproducts() async {
    QuerySnapshot qn = await _db.collection("products").get();

    return qn;
    
  }
}
