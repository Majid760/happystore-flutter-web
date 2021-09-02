import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  static final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  FirebaseController() {
    FirebaseController.firestoreInstance
        .collection('products')
        .snapshots()
        .listen((event) {
      event.docs.forEach((result) {
        print(result.data()['ProductID']);
        print(result.data()['Product Name']);
      });
    });
  }

  // get product stream from firebase

  Stream<QuerySnapshot<Map<String, dynamic>>> get products_stream {
    return FirebaseController.firestoreInstance
        .collection('products')
        .snapshots();
  }
}
