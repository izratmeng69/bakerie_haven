//import 'package:flutter/material.dart';
//import 'package:firebase_storage/firebase_storage.dart';

import 'package:equatable/equatable.dart';
//import 'package:bakerie_haven/models/product.dart';

class Product extends Equatable {
  final int index;
  final String itemId;
  final String supplierId;
  final String itemName;
  final double price;
  List tags;

  Product({
    required this.index,
    required this.itemId,
    required this.supplierId,
    required this.itemName,
    required this.price,
    required this.tags,
  });
  Product copyWith({String? itemId}) {
    return Product(
            index: index, // ?? this.index,
            itemId: itemId!, // ?? this.itemId,
            supplierId: supplierId, //this.supplierId,
            itemName: itemName, // ?? this.itemName,
            price: price, // ?? this.price,
            tags: tags) // ?? this.tags);
        ;
  }

  factory Product.fromSnapshot(Map<String, dynamic> snap, int index) {
    return Product(
        index: index,
        itemId: snap['itemId'],
        itemName: snap['itemName'],
        supplierId: snap['supplierId'],
        price: snap['price'],
        tags: snap['tags']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [itemId, itemName, supplierId, price, tags];
  static List<Product> products = [
    Product(
        index: 0,
        itemId: ' Something to eat bhai',
        supplierId: 'rikkiiiki',
        itemName: 'packashit',
        price: 100,
        tags: ['crack', 'hard'])
  ];
}

class Cat extends Equatable {
  final int index;
  final String catId;
  //final String supplierId;
  final String catName;
  final String description;
  //final double price;
  List similarTags;

  Cat({
    required this.index,
    required this.catId,
    //  required this.supplierId,
    required this.catName,
    required this.description,
    //required this.price,
    required this.similarTags,
  });
  Cat copyWith({String? itemId}) {
    return Cat(
      index: index, //?? this.index,
      catId: catId, // ?? this.catId,
      description: description, // ?? this.description,
      //  supplierId: supplierId ?? this.supplierId,
      catName: catName, // ?? this.catName,
      // price: price ?? this.price,
      similarTags: similarTags,
    ) // ?? this.similarTags);
        ;
  }

  factory Cat.fromSnapshot(Map<String, dynamic> snap, int index) {
    return Cat(
        index: index,
        catId: snap['catId'],
        catName: snap['catName'],
        description: snap['description'],
        // supplierId: snap['supplierId'],
        // price: snap['price'],
        similarTags: snap['similarTags']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [catId, catName, description, similarTags];
  static List<Cat> categories = [
    Cat(
        index: 0,
        catId: 'cat1',
        // supplierId: 'rikkiiiki',
        catName: 'Crackers',
        description: 'Crackers and biscuits ',
        //price: 100,
        similarTags: ['crack', 'hard']),
    Cat(
        index: 0,
        catId: 'cat2',
        description: 'Ice cream Chocolate and Pastries',
        // supplierId: 'rikkiiiki',
        catName: 'Dessert',
        //price: 100,
        similarTags: ['cold', 'creamy']),
  ];
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

class CurrentUser {
  final String uid;

  CurrentUser({required this.uid});
}
