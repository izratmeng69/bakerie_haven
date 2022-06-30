import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:bakerie_haven/models/currentuser.dart';
import 'package:bakerie_haven/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/shared/loading.dart';
import 'package:bakerie_haven/models/product.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io'
    as io; // for File? class, filepicker- apparently it supports all devices now
import 'package:path/path.dart'; //needed for basename, file picker
import 'dart:async';
//import 'dart:html'; //hide File;
import 'dart:typed_data';
import 'package:bakerie_haven/Services/auth.dart';

class SettingsForm extends StatefulWidget {
  final CurrentLoginDetails details;

  SettingsForm({required this.details});
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  //SharedPreferences? sharedPreferences;
  //String? _type = "unknown";

  //sharedPreferences!.setInt('c', 0);

  @override
  void initState() {
    // TODO: implement initState

    print("the user is now a " + widget.details.userType);
    super.initState();
  }

  String? _currentName;
  int _age = 20;
  String _currentIcening =
      "Chocolate"; //This is the selection value. It is also present in my array.
  final _icening = ["Chocolate", "Vanilla", "Strawberry", "Coconut"];
  final _avatars = [
    "https://mintspace-media.fra1.digitaloceanspaces.com/wp-content/uploads/2021/10/28063209/0516.png",
    "https://t4.ftcdn.net/jpg/02/45/28/17/360_F_245281721_2uYVgLSFnaH9AlZ1WWpkZavIcEEGBU84.jpg",
    "https://static.wikia.nocookie.net/ccc6e130-4615-41cc-bf42-50dcaf6fef5f",
    "https://image.winudf.com/v2/image/Y29tLmluY2F0cm8ud2FsbHBhcGVyc2Ric19zY3JlZW5fMF8xNTIzNDMyMjU1XzAzMA/screen-0.jpg?fakeurl=1&type=.webp"
  ]; //This is the array for dropdown

  //filkepicker
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
    final fileName = basename(myFile!.path);
    final destination = 'profiles/$fileName';

    FirebaseApi.uploadFile(destination, myFile!);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);
    //final Future
    final fileName = myFile != null ? basename(myFile!.path) : 'no file picked';
    // final String _stream;
    //vecause we needto acesss context

    print(" we have reached the settings form");
    print(widget.details.userType);
    print(user!.uid);
    return (widget.details.userType == "customer")
        ? StreamBuilder<CustData>(
            //initialData: null,
            stream: DatabaseService(uid: user.uid).custData,
            // : DatabaseService(uid: user!.uid).supData,
            //this creates a databaseservice onject with our current user id
            builder: (context, snapshot) {
              //nothing to do with firebase, this is a built influtter stream
              if (snapshot.hasData) {
                print("we are receiving data for customer");
                //user data of customer created to return stream data of the customer account
                CustData userData = snapshot.data!;
                return Form(
                  key: _formKey,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text("Update form settings"),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          _selectFile();
                        },
                        child: ClipOval(
                            child: Image.network(
                                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLeqsbTn6eqpr7PJzc/j5ebf4eLZ3N2wtrnBxsjN0NLGysy6v8HT1tissra8wMNxTKO9AAAFDklEQVR4nO2d3XqDIAxAlfivoO//tEOZWzvbVTEpic252W3PF0gAIcsyRVEURVEURVEURVEURVEURVEURVEURVEURVEURflgAFL/AirAqzXO9R7XNBVcy9TbuMHmxjN6lr92cNVVLKEurVfK/zCORVvW8iUBnC02dj+Wpu0z0Y6QlaN5phcwZqjkOkK5HZyPAjkIjSO4fIdfcOwFKkJlX4zPu7Ha1tIcwR3wWxyFhRG6g4Je0YpSPDJCV8a2Sv2zd1O1x/2WMDZCwljH+clRrHfWCLGK8REMiql//2si5+DKWKcWeAGcFMzzNrXC/0TUwQ2s6+LhlcwjTMlYsUIQzPOCb7YBiyHopyLXIEKPEkI/TgeuiidK/R9FniUDOjRDpvm0RhqjMyyXNjDhCfIMYl1gGjIMIuYsnGEYRMRZOMMunaLVwpWRW008v6fYKDIzxCwVAeNSO90BJW6emelYBRF/kHpYGVaoxTDAaxOFsfP9y8hpJ4xd7gOcij7JNGQ1EYFgkPJa1jQEiYZXRaRINKxSDUW9n+FT82lSKadkiru9/4XPqSLWOekGPoY05TAvLm9orm+YWuwHoBHkZKijNBJGmeb61eL6Ff/6q7bLr7yvv3vKGhpDRjvgjGaPz+gUg6YgcvpyAR2FIZ9U6nEEyZRTovmEU32KichpGn7C17XrfyH9gK/c0CMP05HZIM2uf9sEveizKveBy9/6Qt7o89ne33D525cfcIMW6ab+TMEukQbQbu+xu7X3A9bChmWaCeAkG17bpntwXgWxHaMzGPmUaR5dQZiKqRVeUZ3047fi3nAu28h4CHxCsZAgmEH8Y27jJAhm8c+5RQzRQNVGhVFSfxOYIjp/pP7RxzjevYXVGf4eLt+BJ1vCuLuLkrgABgCGXZ2wik5uty+oBvNirI6mkzhAf4Gsb58Hcm67Jzd+KwD10BYPLL3e0MjvKrgAULnOfveF/O4N2Xb9BZom3gJes3F9X5Zze8/6Yt09b4CrqsEjUv8oFBaR2rl+6CZr2xVrp24o/WitBKuGrrpl1+bFkmK2qXTON4VpbdfLa7o7y/WdLxG7lm2Lqh2clOwTegbvc/vj2U78CwhA87Bn8G5Nk3eOb0Nsr9flz3sG78UUtue4kpv1xvjg3TMay62BMlTlP+vrOMnJsRmt/ze0jsfkPPYdAH57hK+34PeOyc8XIXu5xT2HsUkdZz+adwg8HGFfQ3K5jtDvbUiO4Di9/ywHGrL88pDizZ++oTp+an+SMX/ndymUCwmHMdO7yuOx83pUx/eEMU0AvxWndwgidAqOZ8ypCwdEfvvEo6D9HwpA8wzvmOJEqAg9ySu8g4x0Hb9hSB/BANEKJ+LbPBU0lzbAJs4xt1AoshKkUGQmiH8/jJ0gdhTTLmSegHlPE0oOdXALnqDjKYh3px//fSgSWG8UqfrrIICzYYSJXRr9BSPbpNzw7gBjKjKOYI7ReIGqQRIap5+5MdjyvuDkExvGeXSlONWZAP3/AZBwJohU7QJRGU+cTVH18ELmRPNBmibW6MT/k1b0XhdkRBvyT6SB6EYv/GvhSmRNpGngRULsAlxMCGNXp7w3FfdEbTEEDdLI9TdIKRUzUesa3I461ER8cpNT7gMRhpKmYVS9ELOgCUQsa4SsulciKiLbY+AnHD8cpuhISsnxpamI84sbDq9qYJgf8wiiOBrC7Ml7M7ZECCqKoiiKoiiKoiiKoijv5AvJxlZRyNWWLwAAAABJRU5ErkJggg==')),
                      ),
                    ),
                    ClipOval(
                        child: userData.url != "customer" &&
                                userData.url != "supplier"
                            ? Image.asset('users/' + userData.url + ".png")
                            : Image.network(userData.url)),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Ënter your name",
                              hintStyle: TextStyle(color: Colors.black)),
                          validator: (val) =>
                              val!.isEmpty ? "Enter a username" : null,
                          onChanged: (val) =>
                              setState(() => _currentName = val)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    //slider

                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField(
                        decoration:
                            textInputDecoration, //(hintText: "Select icening"),
                        value: _currentIcening,
                        items: _icening
                            .map((String item) => DropdownMenuItem<String>(
                                child: Text(item), value: item))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            // this._currentIcening = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Colors.brown, //shade the slider
                        inactiveColor: Colors.brown[userData.age],
                        value: userData.age < 100 ? 100 : _age.toDouble(),

                        onChanged: (double val) {
                          setState(() {
                            _age = val.toInt();
                            print(_age); //rounds double to neaerest int
                          });
                        },
                        min: 100,
                        max: 900,
                        divisions: 8, //spaces in between 1-9
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            uploadFile();
                            /*await DatabaseService(uid: user.uid).updateCustData(
                                "mr.meeseeks", userData.age, "SFO");
                            /*(_price ?? userData.price).toInt() "pth");*/*/
                            Navigator.pop(context);
                          } else {}
                        },
                        child: Text("Purchase"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ]),
                );
              } else {
                return Loading();
              }
            })
        : (widget.details.userType == "supplier")
            ? StreamBuilder<SupplierData>(
                stream: DatabaseService(uid: user.uid).supData,
                // : DatabaseService(uid: user!.uid).supData,
                //this creates a databaseservice onject with our current user id
                builder: (context, snapshot) {
                  //nothing to do with firebase, this is a built influtter stream
                  if (snapshot.hasData) {
                    print("we are receiving data for supplier");
                    //user data of customer created to return stream data of the customer account
                    SupplierData userData = snapshot.data!;
                    return Form(
                      key: _formKey,
                      child: Column(children: [
                        const Expanded(
                          child: Text("Update form settings"),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () async {
                              _selectFile();
                            },
                            child: ClipOval(
                              child: userData.url == 'supplier'
                                  ? Image.network(
                                      'https://static.vecteezy.com/system/resources/thumbnails/003/126/397/small/line-icon-for-deliverable-vector.jpg',
                                      height: 100,
                                      width: 100,
                                    )
                                  //Carousel
                                  : Image.network(userData.url),
                            ),
                          ),
                        ),
                        //ClipOval(child: Image.network(userData.url)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton.icon(
                            //can also use textbutton
                            onPressed: () async {
                              await _auth.signOut();
                              int count = 1;
                              Navigator.of(context)
                                  .popUntil((_) => count++ >= 2);
                            },
                            icon: Icon(Icons.person),
                            label: Text("Logout"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                minimumSize: const Size(
                                  200,
                                  50,
                                ),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //Text(fileUrl),
                        /*Expanded(
                          flex: 2,
                          child: TextFormField(
                              initialValue: userData.name,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Ënter your name"),
                              validator: (val) =>
                                  val!.isEmpty ? "Enter a username" : null,
                              onChanged: (val) =>
                                  setState(() => _currentName = val)),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        //slider

                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField(
                            decoration:
                                textInputDecoration, //(hintText: "Select icening"),
                            value: _currentIcening,
                            items: _icening
                                .map((String item) => DropdownMenuItem<String>(
                                    child: Text(item), value: item))
                                .toList(),
                            onChanged: (String? value) {
                              setState(() {
                                // this._currentIcening = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.brown, //shade the slider
                            inactiveColor: Colors.brown[userData.age],
                            value: userData.age < 100 ? 100 : _age.toDouble(),

                            onChanged: (double val) {
                              setState(() {
                                _age = val.toInt();
                                //print(_age); //rounds double to neaerest int
                              });
                            },
                            min: 100,
                            max: 900,
                            divisions: 8, //spaces in between 1-9
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                uploadFile();
                                /*await DatabaseService(uid: user.uid).updateCustData(
                                "mr.meeseeks", userData.age, "SFO");
                            /*(_price ?? userData.price).toInt() "pth");*/*/
                                Navigator.pop(context);
                              } else {}
                            },
                            child: Text("Purchase"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                          ),
                        ),*/
                      ]),
                    );
                  } else {
                    return Loading();
                  }
                })
            : Text('We have no userType stream');
  }
}
/*StreamBuilder<SupplierData>(
            stream: DatabaseService(uid: user!.uid).supData,
            // : DatabaseService(uid: user!.uid).supData,
            //this creates a databaseservice onject with our current user id
            builder: (context, snapshot) {
              //nothing to do with firebase, this is a built influtter stream
              if (snapshot.hasData) {
                SupplierData userData = snapshot.data!;
                return Form(
                  key: _formKey,
                  child: Column(children: [
                    const Expanded(
                      child: Text("Update form settings"),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Ënter your name"),
                          validator: (val) =>
                              val!.isEmpty ? "Enter a username" : null,
                          onChanged: (val) =>
                              setState(() => _currentName = val)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    //slider

                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField(
                        decoration:
                            textInputDecoration, //(hintText: "Select icening"),
                        value: _currentIcening,
                        items: _icening
                            .map((String item) => DropdownMenuItem<String>(
                                child: Text(item), value: item))
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            this._currentIcening = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        activeColor: Colors.brown, //shade the slider
                        inactiveColor: Colors.brown[userData.age],
                        value: userData.age.toDouble(),
                        onChanged: (val) {
                          setState(() {
                            _age = val.toInt(); //rounds double to neaerest int
                          });
                        },
                        min: 100,
                        max: 900,
                        divisions: 8, //spaces in between 1-9
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            print(_currentName);
                            print(_currentIcening);
                            print(_age);
                            /*await DatabaseService(uid: user.uid).updateCustData(
                                "mr.meeseeks", userData.age, "SFO");
                            /*(_price ?? userData.price).toInt() "pth");*/*/
                            Navigator.pop(context);
                          } else {}
                        },
                        child: Text("Purchase"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                      ),
                    ),
                  ]),
                );
              } else {
                return Loading();
              }
            })*/
// Text(" Bhoi u a supplier! ");
