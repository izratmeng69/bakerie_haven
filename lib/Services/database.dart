import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:bakerie_haven/models/product.dart';

import 'package:bakerie_haven/models/currentuser.dart';
import 'package:firebase_storage/firebase_storage.dart';

//images in storage
class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  DatabaseService.withoutUID() : uid = "";

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');
  final CollectionReference custCollection =
      FirebaseFirestore.instance.collection('Customers');
  final CollectionReference supCollection =
      FirebaseFirestore.instance.collection('Suppliers');
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('ItemInfo');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  //'orders collectio  nwill be created if it doesnt already exists

//adding user data to bakerie app

  Future updateCustData(
      String email, String name, int age, String address, String url) async {
    return await custCollection.doc(uid).set({
      'custId': uid,
      'email': email,
      'name': name,
      'age': age,
      'address': address,
      'url': url,
      //'address':address;
      // 'ref':ref,
    }); //will create if doesnt exist
  }

  Future updateUserData(String email, String password, String type) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'pass': password,
      'user': type,
      //'address':address;
      // 'ref':ref,
    }); //will create if doesnt exist
  }

  Future updateSupplierUserData(
      String email, String username, String location, String url) async {
    return await supCollection.doc(uid).set({
      'supplierId': uid,
      'email': email,
      'supplierName': username,
      'location': location,
      'url': url,
      // 'ref':ref,
    }); //will create if doesnt exist
  }

  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustData(snapshot.get('custId'), snapshot.get('name'),
        snapshot.get('age'), snapshot.get('address'), snapshot.get('url'));
  }

  Stream<CustData> get custData {
    return custCollection.doc(uid).snapshots().map(_custDataFromSnapshot);
    //Reading from users database, we take our uid as a parameter and maps it to our userdata object
  }

  Stream<CurrentLoginDetails> get details {
    return userCollection.doc(uid).snapshots().map(_detailsFromSnapshot);
  }

  CurrentLoginDetails _detailsFromSnapshot(DocumentSnapshot snapshot) {
    return CurrentLoginDetails(
      snapshot.get('uid'),
      snapshot.get('email'),
      snapshot.get('user'),
      snapshot.get('pass'),
      snapshot.get('tags'),
    );
  }

  SupplierData _supplierDataFromSnapshot(DocumentSnapshot snapshot) {
    return SupplierData(
      snapshot.get('supplierId'),
      snapshot.get('supplierName'),
      snapshot.get('location'),
      //snapshot.get('rating'),
      //snapshot.get('age'),
      snapshot.get('url'),
    );
  }

  Stream<SupplierData> get supData {
    return supCollection.doc(uid).snapshots().map(_supplierDataFromSnapshot);
    //Reading from users database, we take our uid as a parameter and maps it to our userdata object
  }

  //useradata from snapshot

  /*Stream<QuerySnapshot?> get snap {
    //snapshot of orders
    return orderCollection.snapshots();
  } //old stream returning snapshot-unused*/

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs //create list of product objects from mapped docs snap
        .map((e) => Product(
              e.get('itemId'),
              e.get('supplierId'),
              e.get('itemName'),
              e.get('price'),
              // e.get('cat'),
              e.get('tags'),

              // e.get('link'),
            ))
        .toList();
    //List<Product> products;
  }

  /*List<String> convert(List<dynamic> array) {
    //from list of dynamic to list f strings-used for reading arrays in firestore
    final List<String> strs = array.map((e) => e.toString()).toList();
    return strs;
  }*/

//stream of list of products
  Stream<List<Product>> get items {
    print(" weare viewing item table");
    //gets all itemson sale
    return itemCollection.snapshots().map(_productListFromSnapshot);
  }

  Stream<List<Product>> get basicItems {
    //items from this supplier account
    //only lists items from current suppliers'perspective
    return itemCollection
        .where('suppliers',
            arrayContains:
                uid.toString()) //where('suppliers'.contains(uid.toString()))
        .snapshots()
        .map(_productListFromSnapshot);
  }

  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs //create list of product objects from mapped docs snap
        .map((e) => Order(
              e.get('itemName'),
              e.get('itemId'),
              e.get('supplierId'),
              e.get('quantity'),
            ))
        .toList();
  }

//return list of products
  Stream<List<Order>> myOrders(String uid) {
    //items from this supplier account
    //only lists items from current suppliers'perspective
    return orderCollection
        .where('supplierId',
            isEqualTo:
                uid.toString()) //where('suppliers'.contains(uid.toString()))
        .snapshots()
        .map(_orderListFromSnapshot);
  }

//Query Stream, change streams with if then else using widget variable
  Stream<List<Product>> expensive() {
    return itemCollection
        // .where('price', isGreaterThanOrEqualTo: 400)
        .snapshots()
        .map(_productListFromSnapshot);
  }

  Stream<List<Product>> get myItems {
    print("we are viewing supplier table");
    //items from this supplier account
    //only lists items from current suppliers'perspective
    return itemCollection
        // .where('supplierId' ==
        ///     uid.toString()) //where('suppliers'.contains(uid.toString()))
        .snapshots()
        .map(_productListFromSnapshot);
  }

  int get myItemCount {
    //List<DocumentSnapshot> snap=itemCollection.where('supplierId',isEqualTo:
    //uid.toString()).snapshots();
    return 5;
  }
}
