import 'package:bakerie_haven/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/screens/home/product_tile.dart';
import 'package:bakerie_haven/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:bakerie_haven/screens/home/image_page.dart';

class ProductsList extends StatefulWidget {
  //const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late Future<List<FirebaseFile>> futureFiles;
  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll(
        'files/'); //gets all links, filename etc from storage, of which we will show in a future builder when we return it as a widget
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(
        //we get a stream of prodsucts from home screen
        context); //?? [];my null check game me an error
    if (products == [])
      return (Text("Failed to receive products list"));
    else {
//and we are displaying the item images of that same item index from the storage
      return Expanded(
        flex: 3,
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
                      buildHeader(products.length),
                      const SizedBox(height: 12),
                      products.length == 0
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 20,
                                      spreadRadius: 2.0,
                                      blurStyle: BlurStyle.outer)
                                ],
                                border: Border.all(),
                              ),
                              //color: Colors.white,
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      'NO products available. This may be an errpr. Would yoj like to notify us?',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
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
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w800),
                                        )),
                                  ),
                                  
                                ],
                              ),
                            )
                          : Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return ProductTile(
                                    index: index,
                                    prod: products[index],
                                    file: files[index],
                                  );
                                },
                              ),
                            )
                    ],
                  );
                }
            }
          },
        ),
      );
    }
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
        /* onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )),*/
      );

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 73, 23, 23),
          ),
        ),
      );
}
