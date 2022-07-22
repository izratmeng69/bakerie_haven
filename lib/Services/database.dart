import 'package:bakerie_haven/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:bakerie_haven/models/streams.dart';

import 'package:bakerie_haven/models/models.dart.dart';
import 'package:firebase_storage/firebase_storage.dart';

//images in storage
class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // DatabaseService.withoutUID() : uid = "";

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('Orders');
  final CollectionReference custCollection =
      FirebaseFirestore.instance.collection('Customers');
  final CollectionReference supCollection =
      FirebaseFirestore.instance.collection('Suppliers');
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('Products');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference catCollection =
      FirebaseFirestore.instance.collection('Categories');
  //'orders collectio  nwill be created if it doesnt already exists

//adding user data to bakerie app

  Future addItem(int myItemCount, String itemName, double price,
      String supplierId, List tags) async {
    String itemId = supplierId + 'item' + (myItemCount + 1).toString();
    await itemCollection.doc(itemId).set({
      'itemId': itemId,
      'itemName': itemName,
      'price': price,
      'supplierId': supplierId,
      'tags': tags
    });
    return await supCollection
        .doc(supplierId)
        .update({'myItemCount': myItemCount + 1});
  }

  Future updateItemData(
      String itemId, String itemName, double price, List tags) async {
    return await itemCollection.doc(itemId).update({
      'itemName': itemName,
      'price': price,
      'tags': tags
    }); //will create if doesnt exist
  }

  Future updateCustData(
      String name, int age, String address, String url) async {
    return await custCollection.doc(uid).set({
      'custId': uid,
      'name': name,
      'age': age,
      'address': address,
      'url': url,
    }); //will create if doesnt exist
  }

  Future updateUserData(String email, String password, String type) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'pass': password,
      'user': type,
    }); //will create if doesnt exist
  }

  Future updateSupplierUserData(String email, String username, String location,
      String url, int count) async {
    return await supCollection.doc(uid).set({
      'supplierId': uid,
      //'email': email,
      'supplierName': username,
      'location': location,
      'url': url,
      'myItemCount': count
      // 'ref':ref,
    }); //will create if doesnt exist
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
    );
  }

  CustData _custDataFromSnapshot(DocumentSnapshot snapshot) {
    return CustData(snapshot.get('custId'), snapshot.get('name'),
        snapshot.get('age'), snapshot.get('address'), snapshot.get('url'));
  }

  SupplierData _supplierDataFromSnapshot(DocumentSnapshot snapshot) {
    return SupplierData(
      snapshot.get('supplierId'),
      snapshot.get('supplierName'),
      snapshot.get('location'),
      snapshot.get('url'),
      snapshot.get('myItemCount'),
    );
  }

  Stream<SupplierData> get supData {
    return supCollection.doc(uid).snapshots().map(_supplierDataFromSnapshot);
    //Reading from users database, we take our uid as a parameter and maps it to our userdata object
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .asMap()
        .entries
        .map((e) => Product(
            index: e.key,
            itemId: e.value['itemId'],
            supplierId: e.value['supplierId'],
            itemName: e.value['itemName'],
            price: e.value['price'],
            tags: e.value['tags']))
        .toList(); //create list of product objects from mapped docs snap
  }

  List<Cat> _CatListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .asMap()
        .entries
        .map((e) => Cat(
            index: e.key,
            catId: e.value['catId'],
            description: e.value['description'],
            //   supplierId: e.value['supplierId'],
            catName: e.value['catName'],
            //price: e.value['price'],
            similarTags: e.value['similarTags']))
        .toList(); //create list of product objects from mapped docs snap
  }

//stream of list of products
  Stream<List<Product>> get items {
    print(" wear viewing item table");
    //gets all itemson sale
    return itemCollection.snapshots().map(_productListFromSnapshot);
  }

  Stream<List<Cat>> get cats {
 //   print(" wear viewing item table");
    //gets all itemson sale
    return catCollection.snapshots().map(_CatListFromSnapshot);
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
}
