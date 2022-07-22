//import 'package:bakerie_haven/shared/constants.dart';
//import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/screens/itemscreens/product_tile.dart';
import 'package:bakerie_haven/models/streams.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:bakerie_haven/screens/itemscreens/image_page.dart';
import 'package:bakerie_haven/shared/constants.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io'
    as io; // for File? class, filepicker- apparently it supports all devices now
import 'package:path/path.dart'; //needed for basename, file picker
import 'dart:async';
//import 'dart:html'; //hide File;
import 'dart:typed_data';

class ProductsList extends StatefulWidget {
  //const ProductsList({Key? key}) : super(key: key);
  SupplierData? supData;
  CustData? custData;
  CurrentLoginDetails details;
  String query; //here
  ProductsList(
      {Key? key,
      required this.details,
      required this.query,
      required this.custData,
      required this.supData})
      : super(key: key);
  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late Future<List<FirebaseFile>> futureFiles;
  late Future<List<FirebaseFile>> futureFiles2;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll(
        'files/');
        futureFiles2 = FirebaseApi.listAll(
        'categories/'); //gets all links, filename etc from storage, of which we will show in a future builder when we return it as a widget
  }

  Future<void> _refresh() async {
    return;
  }

  UploadTask? task;
  io.File? myFile;

  Future _selectFile() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
// Android specific code
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      final path = result.files.single.path;

      setState(() {
        myFile = io.File(path!);
      });
    } else {
      WebFilePicker();
//web or desktop specific code
    }
    //for only one file, allow multiple :false, or
  }

//choose file from flutter web
  Future WebFilePicker() async {
    // variable to hold image to be displayed

    /*  String option1Text = "Initialized text option1";
    late Uint8List? uploadedImage;
    FileUploadInputElement element = FileUploadInputElement()
      ..id = "file_input";
    // setup File Reader
    FileReader fileReader = FileReader();
//method to load image and update `uploadedImage`

    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result as Uint8List;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        //reader.readAsArrayBuffer(file);
        setState(() {
          myFile = File.fromRawPath(uploadedImage!);
        });
      }
    });*/
  }

  //upload file from android , ios or web
  Future uploadFile() async {
    if (myFile == null) return;
    final fileName =
        widget.details.uid.toString() + '.png'; //basename(myFile!.path);
    final destination = 'profiles/$fileName';
    print(destination);
    //FirebaseApi.uploadFile(destination, myFile!);
  }

  Widget buildFile(BuildContext context, FirebaseFile file, Product p) =>
      ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url.trim().toString(),
            width: 52,
            height: 52,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          file.url,
          style: Theme.of(context).textTheme.headline1,
        ),
      );

  Widget buildHeader(int length) => Row(
        children: [
          Icon(
            Icons.local_grocery_store,
            color: Colors.deepPurpleAccent,
          ),
          Text(
            '$length',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    void _showAddItemPanel() {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              // height: 300,
              // width: 300,
              color: Color.fromARGB(255, 230, 230, 230),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              decoration: boxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Add a new item',
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                            ),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: InkWell(
                                      child: Image.network(
                                          'https://icon-library.com/images/icon-placeholder/icon-placeholder-16.jpg')),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                validator: (val) => val!.length < 4
                                    ? "Enter a product name with atleast 4 chsracters"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    // password = val;
                                  });
                                },
                                style: Theme.of(context).textTheme.headline1,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Product Name',
                                    hintStyle:
                                        TextStyle(color: Colors.black12)),
                              ),
                            ),
                            TextFormField(
                              validator: (val) => double.tryParse(val!)! > 0
                                  ? "price must be greater than 0"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  // password = val;
                                });
                              },
                              style: Theme.of(context).textTheme.headline1,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'price',
                                  hintStyle: TextStyle(color: Colors.black12)),
                            ),
                          ],
                        )),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: /*Expanded(flex: 1, child: */ Icon(
                        Icons.arrow_downward) /*)*/,
                  )
                ],
              ),
            );
          });
    }
    final cats = Provider.of<List<Cat>>(context);
    final products = Provider.of<List<Product>>( context); //?? [];my null check game me an error
    if (products == [])
      return (Text("Failed to receive products list"));
    else {
//and we are displaying the item images of that same item index from the storage
      return Flexible(
        flex: 3,
        child: Container(
          //Conatiner do not need size within flexible
          child: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Some Error occurred!'));
                  } else {
                    final files = snapshot.data!;

                    return Column(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.details.userType == "supplier" ||
                                  widget.details.userType == "customer"
                              ? products.length == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 230, 230, 230),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1, 1),
                                              blurRadius: 20,
                                              spreadRadius: 2.0,
                                              blurStyle: BlurStyle.outer)
                                        ],
                                        border: Border.all(),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                              'NO products available. This may be an error. Would you like to notify us?',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.pinkAccent,
                                                  fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.w800)),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextButton.icon(
                                                onPressed: () {},
                                                icon: Icon(Icons.call),
                                                label: Text(
                                                  "send feedback",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Flexible(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            color: Colors.black12,
                                            child: Row(
                                              children: [
                                                widget.details.userType ==
                                                        "supplier"
                                                    ? buildHeader(
                                                        products.length)
                                                    : SizedBox(),
                                                widget.details.userType ==
                                                        "supplier"
                                                    ? IconButton(
                                                        onPressed: () {
                                                          _showAddItemPanel();
                                                        },
                                                        icon: Icon(
                                                            Icons.plus_one))
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: RefreshIndicator(
                                              onRefresh: _refresh,
                                              child: FutureBuilder<List<FirebaseFile>>(
                                                future: futureFiles2,
                                                builder: (context, snapshot) {
                                                  switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Some Error occurred!'));
                  } else {
                    final files2 = snapshot.data!;
                                                  return ListCard(
                                                    catFiles: files2,
                                                      query: widget.query,
                                                      products: products,
                                                      type: 'supall',
                                                      categories: cats,
                                                      files: files);
                                                }
                                                  }}
                                            ),
                                          ),
                                          )]
                                      ))
                              : Text(
                                  'Error retrieving user details on product screen'),
                        ]);
                  }
              }
            },
          ),
        ),
      );
    }
  }
}

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.query,
    required this.type,
    required this.products,
    required this.categories,
    required this.files,
    required this.catFiles,
    this.sup,this.cust
  }) : super(key: key);

  final List<Product> products;
  final List<Cat> categories;
  // final ProductsList widget;
  final CustData? cust;
  final SupplierData? sup;
  final String type;
  final String query;
  //final ProductsList widget;
  final List<FirebaseFile> files;
  final List<FirebaseFile> catFiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        type == 'supall'
                  ? 
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: TextButton.icon(
                label: Text('Add Item'),
                icon: Icon(Icons.add_a_photo),
                onPressed: () {},
              ),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: // type == "all || item"
                          products.length,
                      //: categories.length,
                      itemBuilder: (context, index) {
                        if (products[index]
                                .itemName
                                //  .toLowerCase()
                                .contains(query) ||
                            products[index].tags.contains(query)) {
                          return ProductTile(
                            index: index,
                            prod: products[index],
                            file: files[index],
                          );
                        } else {
                          return SizedBox(
                            height: 1,
                          );
                        }

                        //  return Text(''); //CategoryList();
                      })
                  
            ),
          ],
        ):
        Container(height: 120,child:)//create cattile like product tile
      ],
    );
  }
}
