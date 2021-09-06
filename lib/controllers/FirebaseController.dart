import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController {
  static final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  FirebaseController() {
    
  }

  // get product stream from firebase

  Stream<QuerySnapshot<Map<String, dynamic>>> get products_stream {
    return FirebaseController.firestoreInstance
        .collection('products')
        .snapshots(includeMetadataChanges: true);
  }
}
