import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:bakerie_haven/models/streams.dart';
import 'package:bakerie_haven/screens/itemscreens/image_page.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  final Product prod;
  ImagePage({
    // Key? key,
    required this.file,
    required this.prod,
  }); // : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
        appBar: AppBar(
          title: Text(prod.itemName),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                await FirebaseApi.downloadFile(file.ref);

                final snackBar = SnackBar(
                  content: Text('Downloaded ${file.name}'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      file.url,

                      // height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              /* Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(prod.itemName))
                    ],
                  ),*/
            ),
            Flexible(
                flex: 1,
                child: Chip(
                  label: Text(prod.itemName),
                )),
          ],
        ));
  }
}
