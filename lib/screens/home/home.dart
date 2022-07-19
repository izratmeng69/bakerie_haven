// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:math';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:bakerie_haven/Services/auth.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakerie_haven/models/product.dart';
import 'package:bakerie_haven/screens/home/location.dart';
import 'package:bakerie_haven/screens/itemscreens/product_list.dart';
import 'package:bakerie_haven/screens/itemscreens/product_tile.dart';
import 'package:bakerie_haven/screens/home/settings_form.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:bakerie_haven/widgets/extras/appbar.dart';
import 'package:bakerie_haven/shared/widgets/extras/navbar.dart';
import 'package:bakerie_haven/shared/loading.dart';
import 'package:bakerie_haven/shared/constants.dart';
//import 'package:bakerie_haven/shared/session.dart';
import 'package:bakerie_haven/models/currentuser.dart';
//import 'package:cool_nav/cool_nav.dart';
//adding cool nav plugin for flipxbox animated navbar
//import 'package:geolocator/geolocator.dart';
import 'package:bakerie_haven/shared/widgets/extras/search_bar.dart'; //we added permissions for this plugin in main/androidmanifest.xml
//import 'package:bakerie_haven/models/firebase_file.dart';
import 'package:bakerie_haven/Services/firebase_api_storage.dart';
//import 'package:bakerie_haven/screens/home/product_list.dart';
import 'notif.dart';

class Home extends StatefulWidget {
  //String type;

  //String email;

  //String? error = "";
  //Home({required this.email, required this.type});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
//function created here becausewe need access to cntext
    final user = Provider.of<CurrentUser>(context);
    print("user at homepage is+" + user.uid);

    return StreamBuilder<CurrentLoginDetails>(
        stream: DatabaseService(uid: user.uid).details,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CurrentLoginDetails userDetails = snapshot.data!;
            return
                //Center(child: Text(" You are a " + userDetails.userType)),
                // Test(curr: userDetails);
                UserHome(details: userDetails);
          } else {
            return Loading();
          }
        });
  }
}

class UserHome extends StatefulWidget {
  final CurrentLoginDetails details;
  UserHome({super.key, required this.details});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final AuthService _auth = AuthService();
  final _formKeyUserHome = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      //drawer:NavBar()
      appBar: AppBar(),
      //  body:
    );
  }*/
    print('User type from user home is ' + widget.details.userType);
    if (widget.details.userType == "customer") {
      return Form(
          // key: _formKeyUserHome,
          child: StreamBuilder<CustData>(
              stream: DatabaseService(uid: widget.details.uid).custData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  CustData cust = snapshot.data!;
                  return Test(curr: widget.details, cust: cust);
                } else {
                  //error reading cuistomer data
                  return Column(
                    children: [
                      //Text("Something still doesn't work as a customer"),
                      Loading(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          //can also use textbutton
                          onPressed: () async {
                            await _auth.signOut();
                            int count = 1;
                            Navigator.of(context).popUntil((_) => count++ >= 2);
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
                    ],
                  );
                } /*else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(" There is an error in stream builder"),
                    
                    ],
                  );
                }*/
              }));
    } else {
      print('trying to print supplier data');
      //if the user is a supplier
      return Form(
          child: StreamBuilder<SupplierData>(
              stream: DatabaseService(uid: widget.details.uid).supData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SupplierData sup = snapshot.data!;
                  return Test(curr: widget.details, sup: sup);
                } else {
                  //error reading supplier info
                  return Column(
                    children: [
                      // Text("Something still doesn't work as a supplier"),
                      Loading(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          //can also use textbutton
                          onPressed: () async {
                            await _auth.signOut();
                            int count = 1;
                            Navigator.of(context).popUntil((_) => count++ >= 2);
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
                    ],
                  );
                }
              }));
    }
  }
}

class Test extends StatefulWidget {
  final CurrentLoginDetails curr;
  CustData? cust;
  SupplierData? sup;
  //const Test({ Key? key }) : super(key: key);
  Test({required this.curr, this.cust, this.sup});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final AuthService _auth = AuthService();
  bool _isQueried = false;
  int _notifCount = 0;
  final shakeKey = GlobalKey<ShakeWidgetState>(); //for bell icon
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": Home(), "title": "HOME"},
    {"screen": Dashboard(), "title": "DASHBOARD"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
      print(_selectedScreenIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    /* void _showSettingsPanel() {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(details: widget.curr),
            );
          });
    }
*/
    final user = Provider.of<CurrentUser>(context);
    if (widget.curr == null) {
      return Container(child: Center(child: Text("details wanst retrieved")));
    }
    print("the value we got freom details was " + widget.curr.userType);

    if (widget.curr.userType == "supplier")
      print("\nThe location value we got from supplier were " +
          widget.sup!.location);
    else
      print('  We are reading customer, their email is' + widget.curr.email);
    // return //Container(child: Center(child: Text(widget.curr.uid)));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 230, 230, 230),
        elevation: 12.0,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            backgroundColor: Colors.pinkAccent,
          )
        ],
      ),
      body: _selectedScreenIndex == 0 //home bottom nav item
          ? StreamProvider<List<Product>>.value(
              //default list of all products
              initialData: [], //was null,

              value: //_isQueried == false
                  widget.curr.userType == "customer"
                      ? DatabaseService(uid: user.uid).items
                      : DatabaseService(uid: user.uid).myItems, //expensive(),
              child: Scaffold(
                drawer: NavBar(widget.curr),
                backgroundColor: Color.fromARGB(255, 138, 59, 31),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(100.0),
                  child: AppBar(
                    leading: Builder(builder: (BuildContext context) {
                      //this builder gets rid of default navbar humburger menu icon
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(Icons.face));
                    }),
                    /*automaticallyImplyLeading:
                    false, */ //this remo0ves unwanted hamburger menu, guess it doesnt
                    title: Text("Bakerie"),
                    backgroundColor: Color.fromARGB(255, 230, 230, 230),
                    elevation: 0.0,
                    actions: <Widget>[
                      new Container(),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 20,
                            width: 100,
                          )),
                      Expanded(
                        flex: 4,
                        child: IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: MySearchDelegate(
                                widget.sup,
                                widget.cust,
                                widget.curr,
                                context,
                              ),
                            );
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      Expanded(
                          //Notifications
                          flex: 1,
                          child: ShakeWidget(
                            // 4. pass the GlobalKey as an argument
                            key: shakeKey,
                            // 5. configure the animation parameters
                            shakeCount: 3,
                            shakeOffset: 10,
                            shakeDuration: Duration(milliseconds: 500),
                            // 6. Add the child widget that will be animated
                            child: IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () {
                                if (_notifCount == 0)
                                  shakeKey.currentState?.shake();
                                // Scaffold.of(context).openDrawer();
                              },
                            ),
                          ) /**/
                          ),
                    ], //actions inappbar expects widgetlist of buttons
                  ),
                ),
                body: Column(children: [
                  // Text(widget.curr.),
                  ProductsList(
                    details: widget.curr,
                    query: '',
                    custData: widget.cust,
                    supData: widget.sup,
                  ),
                  SizedBox(height: 20),
                  Container(
                      decoration: boxDecoration,
                      alignment: Alignment.bottomCenter,
                      child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              if (_isQueried == false)
                                _isQueried = true;
                              else
                                _isQueried = false;
                            });
                          },
                          icon: Icon(Icons.money),
                          label: Text("List most costly products")))
                ]),
              ),
            )
          : Dashboard(), //if second nav tab is clicked
    );
  }
}

//This class is used to get the query variable
//SearchBar implements stream provider, whose list of products
//are always received as as provider in the products list child
class MySearchDelegate extends SearchDelegate {
  SupplierData? sup;
  CustData? cust;
  CurrentLoginDetails details;
  BuildContext context;
  MySearchDelegate(this.sup, this.cust, this.details, this.context);
  @override
  List<Widget>? buildActions(BuildContext context) {
    [
      //clears all the text in search
      IconButton(
          onPressed: () {
            if (query == '')
              close(context, null);
            else
              query = details.email;
          },
          icon: Icon(Icons.clear_all_outlined))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
    return IconButton(
        onPressed: () {
          close(context, null); //closes search
        },
        icon: Icon(Icons.back_hand));
  }

  @override
  final futureFiles = FirebaseApi.listAll('files/'); //gets
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return // Center(child: Text(query));
        StreamProvider<List<Product>>.value(
      initialData: [],
      value: //_isQueried == false
          details.userType == "customer"
              ? DatabaseService(uid: details.uid).items
              : DatabaseService(uid: details.uid).myItems, //expensive(),
      child: Column(
        children: [
          ProductsList(
            details: details,
            query: query,
            custData: cust,
            supData: sup,
          ), //this fetches product data from the stream provider parent search bar
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // throw UnimplementedError();
    List<String> suggestions = [
      'Chocolate',
      'Puff',
      'Ice Cream',
      'Cake',
      'Savory',
    ];
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            title: Text(suggestion),
          );
        });
  }
}



//Shake the bell icon
