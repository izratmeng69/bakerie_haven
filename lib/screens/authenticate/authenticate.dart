import 'dart:ui';

import "package:flutter/material.dart";
import 'package:bakerie_haven/Services/auth.dart';
import 'package:bakerie_haven/shared/constants.dart';
import 'package:bakerie_haven/shared/loading.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:bakerie_haven/shared/session.dart';

class Authenticate extends StatefulWidget {
  //final Function updateVariables;

  // Authenticate({required this.updateVariables});
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final AuthService _auth = AuthService();
  // SessionManager prefs = SessionManager();

  //basic connection to firebase auth
  final _formKey = GlobalKey<FormState>();
  //   to identify our form with this globalform state key
  bool loading = false;
  String email = 'none';
  String password = 'pass';
  String _type = "unknown";
  String _error = "Registering...";
  bool tapped = false;
  double radius = 200;
  String log = "Authenticate";
  bool switchValue = false;
  double _currentOpacity = 1; //toggle for animated gif

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.blue[300],
              /*appBar: AppBar(
                title: switchValue == false
                    ? const Text("Register")
                    : const Text("Sign In"),
                actions: <Widget>[
                  ElevatedButton.icon(
                    label: switchValue == true
                        ? Text("Sign-In")
                        : Text("Register"),
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      //widget.toggleView(); //instead of this- for state widget
                      //we're accessing the Authenticate widget's function
                    },
                  ),
                ],
                backgroundColor: Colors.blue[500],
              ),*/
              body: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                        child: Text(
                          'Are you a Customer or Supplier?',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      curve: Curves.elasticOut,
                      opacity: _currentOpacity,
                      duration: const Duration(seconds: 10),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          //width: 300,
                          height: 200, //not
                          child: ListView.builder(
                              //created scrollable items list
                              shrinkWrap: true, //aligns to center
                              scrollDirection: Axis.horizontal,
                              itemCount: 2, //3 cards,supplier,customer
                              itemBuilder: (context, index) {
                                return
                                    /*child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(200.0)),*/
                                    Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    //card foreach type
                                    onTap: () {
                                      if (index == 0) {
                                        setState(() {
                                          _type = "customer";
                                          tapped = true;
                                          _currentOpacity = 0;

                                          print(" index at 0 clicked");
                                        });
                                      } else if (index == 1) {
                                        setState(() {
                                          _type = "supplier";
                                          tapped = true;
                                          _currentOpacity = 0;
                                          print(" index at 1 clicked");
                                        });
                                      }
                                    },
                                    child: CircleAvatar(
                                      foregroundColor: Colors.lightBlueAccent,
                                      backgroundImage: index == 0
                                          ? NetworkImage(
                                              'https://www.efficy.com/wp-content/uploads/2019/03/new-customer.png')
                                          : NetworkImage(
                                              'data:image/jpeg;base64,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'),
                                      radius: 80,

                                      //  ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    Center(
                      child: BuildForm(context),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget BuildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      child: Column(children: [
        Form(
          key: _formKey, //created
          //now we can do validation
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'email',
                    hintStyle: TextStyle(color: Colors.black12)),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              TextFormField(
                decoration: textInputDecoration
                    .copyWith(
                        hintText: 'password',
                        hintStyle: TextStyle(color: Colors.black12))
                    .copyWith(labelStyle: TextStyle(color: Colors.black)),
                validator: (val) =>
                    val!.length < 6 ? "Enter a password 6 chars long" : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              switchValue == false
                  ? TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            tapped == true) {
                          setState(() {
                            loading = true;
                          });
                          //if you're Authenticateing

                          //if registering
                          dynamic result;
                          result = await _auth.registerEmailPassword(
                              email, password, _type, "null");
                          //this userresult willbe transformed into data we need
                          if (result == null) {
                            setState(() {
                              _error =
                                  "Please supply a valid email, or an email that does not already have an associated account";
                              loading = false;
                            });
                            //now that we signed in,we must listen for the changes using streams
                          } else {
                            // setVal(result.uid, email, password, _type);
                            // prefs.setEmail(email);
                            //prefs.setType(_type);
                            print("Registered User id :" + result!.uid);
                          }
                        }
                        setState(() {
                          _error = "Please tap the user you want to be";
                          //loading = false;
                        }); //if you're signing in
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))
                  : TextButton(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInEmailPassword(email, password);
                          //this userresult willbe transformed into data we need
                          if (result != null) {
                            // setVal(result.uid, _email, _pw, _type);
                            print("Signed In with user Id: " + result.uid);
                          } else {
                            print("we failed to sign in");
                            setState(() {
                              // setVal(_email, _pw, _type);
                              loading = false;
                              _error =
                                  "Could not sign in with those credentials";
                            });
                          }
                        }
                      }),
            ],
          ),
        ),
        SizedBox(
          height: 20,
          child: Text(_error,
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: buildSwitch(),
          ),
        ),
      ]),
    );
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1.2,
        child: Switch.adaptive(
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.blue,
            value: switchValue,
            onChanged: (value) {
              if (switchValue == false) {
                setState(() {
                  _error = "Signing In...";
                  _currentOpacity = 0;
                  // value = true;
                  switchValue = true;
                });
              } else if (switchValue == true) {
                setState(() {
                  _currentOpacity = 1;
                  _error = "Registering...";
                  switchValue = false;
                });
              }
              this.switchValue =
                  value; //the value variable created when the class was created gets updated to the switch variable
            }),
      );
}
