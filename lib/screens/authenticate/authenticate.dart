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
                                              'https://cdn0.iconfinder.com/data/icons/miscellaneous-14-color-shadow/128/deliverable_deliver_courier_occupation_package_parcel_supplier-1024.png'),
                                      radius: 100,

                                      //  ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
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
