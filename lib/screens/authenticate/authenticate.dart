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

  String log = "Authenticate";
  bool switchValue = false;
  double _currentOpacity = 1; //toggle for animated gif
  //String? _type = "unknown";

  /*setVal(String id, String email, String password, String type) async {
    //sets user type only
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('id', id);
    sharedPreferences!.setString('type', type);
    sharedPreferences!.setString('email', email);
    sharedPreferences!.setString('pw', password);
    //sharedPreferences!.setInt('c', 0);
  }*/

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
              body: Column(
                children: [
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
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 2, //3 cards,supplier,customer
                            itemBuilder: (context, index) {
                              return Card(
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
                                  child: buildChoice(context, index),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: BuildForm(context),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildChoice(BuildContext context, int index) {
    //statelesswidgets?
    return Container(
      color: Colors.red,
      child: Column(
        children: [
          index == 0
              ? Container(
                  color: Colors.blueAccent, child: Text('Are you a customer?'))
              : Container(
                  color: Colors.greenAccent,
                  child: Text('Are you a supllier?'),
                ),
          Flexible(
            flex: 2,
            child: Container(
              child: Image(
                  height: 200,
                  // width: 150,
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "images/image" + (index + 1).toString() + ".jpeg")),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(children: [
        Form(
          key: _formKey, //created
          //now we can do validation
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
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
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
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
                            } //if you're signing in
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )))
                  : Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextButton(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.signInEmailPassword(
                                  email, password);
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
                    )
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: Text(_error,
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w700,
                fontSize: 8.0,
              )),
        ),
        Align(alignment: Alignment.bottomCenter, child: buildSwitch()),
      ]),
    );
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1.5,
        child: Switch.adaptive(
            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.blue,
            value: switchValue,
            onChanged: (value) {
              if (_error == "Registering...") {
                setState(() {
                  _error = "Signing In...";
                  _currentOpacity = 0;
                });
              } else if (_error == "Signing In...") {
                setState(() {
                  _currentOpacity = 1;
                  _error = "Registering...";
                });
              }
              this.switchValue =
                  value; //the value variable created when the class was created gets updated to the switch variable
            }),
      );
}
