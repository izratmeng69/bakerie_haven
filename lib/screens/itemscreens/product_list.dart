//import 'package:bakerie_haven/shared/constants.dart';
import 'package:flutter/material.dart';

///import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/screens/itemscreens/product_tile.dart';
import 'package:bakerie_haven/models/product.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:bakerie_haven/screens/itemscreens/image_page.dart';
import 'package:bakerie_haven/shared/constants.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll(
        'files/'); //gets all links, filename etc from storage, of which we will show in a future builder when we return it as a widget
  }

  Future<void> _refresh() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    void _showAddItemPanel() {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 300,
              color: Color.fromARGB(255, 230, 230, 230),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('Add a new item',
                          style: Theme.of(context).textTheme.headline6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // child: Image.network(''),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          TextFormField(
                            style: Theme.of(context).textTheme.headline1,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Product Name',
                                hintStyle: TextStyle(color: Colors.black12)),
                          ),
                          TextFormField(
                            style: Theme.of(context).textTheme.headline1,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'price',
                                hintStyle: TextStyle(color: Colors.black12)),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          });
    }

    final products = Provider.of<List<Product>>(
        //we get a stream of prodsucts from home screen
        context); //?? [];my null check game me an error
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
                                      child: Stack(
                                        children: [
                                          RefreshIndicator(
                                            onRefresh: _refresh,
                                            child: ListView.builder(
                                                itemCount: products.length,
                                                itemBuilder: (context, index) {
                                                  if (products[index]
                                                          .prodName
                                                          //  .toLowerCase()
                                                          .contains(
                                                              widget.query) ||
                                                      products[index]
                                                          .tags
                                                          .contains(
                                                              widget.query)) {
                                                    return ProductTile(
                                                      index: index,
                                                      prod: products[index],
                                                      file: files[index],
                                                    );
                                                  } else {
                                                    return SizedBox();
                                                  }
                                                }),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              widget.details.userType ==
                                                      "supplier"
                                                  ? buildHeader(products.length)
                                                  : Image.network(
                                                      'https://static.thenounproject.com/png/1864268-200.png'),
                                              IconButton(
                                                  onPressed: () {
                                                    if (widget.supData !=
                                                        null) {
                                                      _showAddItemPanel();
                                                    } else {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Text(
                                                                  'Data is null??'),
                                                              height: 30,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      230,
                                                                      230,
                                                                      230),
                                                            );
                                                          });
                                                    }
                                                  },
                                                  icon: Icon(Icons.plus_one)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
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

  Widget buildFile(BuildContext context, FirebaseFile file, Product p) =>
      Container(
        
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListTile(
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.blue,
            ),
          ),
          /* onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImagePage(file: file),
          )),*/
        ),
      );

  Widget buildHeader(int length) => Container(
        height: 30,
        width: 30,
        child: Row(
          children: [
            Icon(
              Icons.local_grocery_store,
              color: Colors.deepPurpleAccent,
            ),
            Text(
              '$length',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
}
