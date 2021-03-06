import 'dart:async';

import 'package:admin/controllers/FirebaseController.dart';
import 'package:admin/services/alert-dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  Product() {
    this.stream = controller.stream;
  }
  StreamController<double> controller = StreamController<double>();
  Stream stream;
  double percent;
  var futureProduct;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference productsReference =
      FirebaseController.firestoreInstance.collection('products');

  Future<void> addProduct(Map product) {
    // Call the user's CollectionReference to add a new user
    return productsReference
        .add(product)
        .then((value) => print("Product Added"))
        .catchError((error) => print('errore $error'));
  }

  void setProductListToFirebase(List<Map> productsList) {
    productsList.forEach((product) => {
          addProduct(product)
          });
  }

  Future getProductsFutre() async{
    futureProduct = await productsReference.limit(100).get();
    notifyListeners();
    return futureProduct;
  }

  
}
