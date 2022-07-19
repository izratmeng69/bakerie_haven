//import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Product {
  final String prodId;
  final String supplierId;
  final String prodName;
  final int price;
  List tags;

  Product(
    this.prodId,
    this.supplierId,
    this.prodName,
    this.price,
    this.tags,
  );
}

class Supplies {
  final String description;
  final String itemId;
  final String itemName;
  final int price;
  Supplies(this.itemId, this.itemName, this.price, this.description);
}

class Order {
  final String itemId;
  final String custId;
  final String supplierId;
  final int quantity;
  Order(this.itemId, this.custId, this.supplierId, this.quantity);
}

class SupplierData {
  final String uid;
  final String name;
  final String location;
  //final String rating;
  //final int age;
  final String url;
  final int count;
  SupplierData(this.uid, this.name, this.location, this.url, this.count);
}

class CustData {
  final String custId;
  final String name;
  final int age; //changed from integer
  final String address;
  final String url;
  CustData(this.custId, this.name, this.age, this.address, this.url);
}

class CurrentLoginDetails {
  final String uid;
  final String email;
  final String userType;
  final String pw;
  CurrentLoginDetails(
    this.uid,
    this.email,
    this.userType,
    this.pw,
  );
}
