import 'package:flutter/material.dart';

import 'package:bakerie_haven/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bakerie_haven/shared/loading.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'image_page.dart';

class ProductTile extends StatelessWidget {
  final int index;
  //final String itemName;
  final Product prod;
  //final int quantity;
  FirebaseFile file;
  //final String url;
  //final String image;
  ProductTile({
    required this.index,
    required this.prod,
    //required this.quantity,
    required this.file,
  });

  //removed curly braces

  @override
  Widget build(BuildContext context) {
    void _showPurchasePanel(int index) {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Pay amount yet for item  of index $index'),
                ),
              ),
            );
          });
    } //end of payment form

    return Card(
        margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        child: InkWell(
          onTap: () {
            _showPurchasePanel(index);
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(file.url),
              ),
              ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      50.0, // Change your border radius here
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePage(prod: prod, file: file),
                      )),
                  leading: ClipOval(
                    //for a tile
                    //  radius: 25.0,
                    //  backgroundColor: Colors.brown[100],
                    child: Image.network(
                      file.url.toString().trim(),
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ), //whats on the left
                  title: Text(prod.prodName),
                  subtitle: Text("thi is an item record of  " + prod.prodName)),
            ],
          ),
        ));
  }
}

/*class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  //FirebaseStorage mImageStorage = FirebaseStorageService.instance();
  static Future<dynamic> loadImage(BuildContext context, String? image) async {
    return FirebaseStorage.instance.ref(
        'https://console.firebase.google.com/project/bakerie_haven999/storage/bakerie_haven999.appspot.com/files' +
            image!);
  }

  Future<String> _getImage(BuildContext context, int index) async {
    String imageName = "avatar1.png"; // "avatar" + index.toString() + ".png";
    var url = await FirebaseStorageService.loadImage(context, imageName);
    var imageurl = await url.getDownloadURL();
    return imageurl;
    //return 'gs://bakerie_haven999.appspot.com/avatar1.png';
  }
}
*/
