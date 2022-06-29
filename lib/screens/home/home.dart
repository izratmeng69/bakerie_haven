// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:bakerie_haven/Services/auth.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bakerie_haven/models/product.dart';
import 'package:bakerie_haven/screens/home/dashboard.dart';
import 'package:bakerie_haven/screens/home/product_list.dart';
import 'package:bakerie_haven/screens/home/product_tile.dart';
import 'package:bakerie_haven/screens/home/settings_form.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bakerie_haven/widgets/navigation/appbar.dart';
import 'package:bakerie_haven/widgets/navigation/navbar.dart';
import 'package:bakerie_haven/shared/loading.dart';
import 'package:bakerie_haven/shared/constants.dart';
//import 'package:bakerie_haven/shared/session.dart';
import 'package:bakerie_haven/models/currentuser.dart';
import 'package:cool_nav/cool_nav.dart';
//adding cool nav plugin for flipxbox animated navbar
import 'package:geolocator/geolocator.dart';
import 'package:bakerie_haven/widgets/navigation/search_bar.dart'; //we added permissions for this plugin in main/androidmanifest.xml

class Home extends StatefulWidget {
  //String type;

  //String email;

  //String? error = "";
  //Home({required this.email, required this.type});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  String option1 = "HOME";
  String option2 = "DASHBOARD";
  bool _switched = false; //these are for bottom navigation
  bool searched = false;
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": Home(), "title": "HOME"},
    {"screen": Dashboard(), "title": "Dashboard"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
      print(_selectedScreenIndex);
    });
  }

  final _formKey = GlobalKey<FormState>();

  List<Widget> v = [];

  //SharedPreferences? prefs;

  void buildRow(String name, String price) {
    v.add(Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue,
        child: Card(
          //width:double.infinity,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  child: Text(name),
                ),
                title: Text(name),
                subtitle: Text("\$" + price.toString()),
                trailing: Text(
                  "x1",
                  style: TextStyle(color: Colors.lightBlue),
                  textScaleFactor: 1.2,
                ),
              ),
            ],
          ),
        )));
  } //buildrow

  @override
  Widget build(BuildContext context) {
//function created here becausewe need access to cntext
    final user = Provider.of<CurrentUser?>(context);
    print("user at homepage is+" + user!.uid);
    //return Text("");
    return StreamBuilder<CurrentLoginDetails?>(
        stream: DatabaseService(uid: user.uid).details,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CurrentLoginDetails userDetails = snapshot.data!;
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
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
                    backgroundColor: Colors.blue,
                  )
                ],
              ),
              appBar: AppBar(
                actions: [
                  //SearchBar(),
                ],
              ), //SearchBar(search: (searched),),
              drawer: NavBar(userDetails),
              key: _formKey,
              body: Column(children: [
                //Center(child: Text(" You are a " + userDetails.userType)),
                Expanded(flex: 3, child: Test(curr: userDetails)),
                //slider
              ]),
            );
          } else {
            return Loading();
          }
        });
  }

  final AuthService _auth = AuthService();

  bool _isQueried = false;
  void _showSettingsPanel(CurrentLoginDetails details) {
    //this is a built in flutter widget fucntion
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SettingsForm(details: details),
          );
        });
  }
}

class Test extends StatefulWidget {
  final CurrentLoginDetails curr;
  //const Test({ Key? key }) : super(key: key);
  Test({required this.curr});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final AuthService _auth = AuthService();
  bool _isQueried = false;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
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

    final user = Provider.of<CurrentUser?>(context);
    if (widget.curr == null) {
      return Container(child: Center(child: Text("details wanst retrieved")));
    }
    print("tyhe value we got was " +
        widget.curr.email +
        " /n You are a " +
        widget.curr.userType);
    // return //Container(child: Center(child: Text(widget.curr.uid)));
    return StreamProvider<List<Product>>.value(
        initialData: [], //was null,

        value: //_isQueried == false
            widget.curr.userType == "customer"
                ? DatabaseService(uid: user!.uid).items
                : DatabaseService(uid: user!.uid).myItems, //expensive(),
        child: Scaffold(
            drawer: new Container(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 138, 59, 31),
            appBar: AppBar(
              automaticallyImplyLeading:
                  false, //this remo0ves unwanted hamburger menu
              title: Text("bakerie"),
              backgroundColor: Colors.amberAccent,
              elevation: 0.0,
              actions: <Widget>[
                new Container(),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 20,
                      width: 100,
                    )),
                Expanded(
                  flex: 2,
                  child: TextButton.icon(
                      onPressed: () {
                        _showSettingsPanel();
                      },
                      icon: Icon(Icons.settings),
                      label: Text("Settings")),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.menu_open),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ], //actions inappbar expects widgetlist of buttons
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg.jpeg'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Column(children: [
                // Text(widget.curr.),
                ProductsList(),
                /*FutureBuilder(
                    future: _getImage(context, 'avatar1.png'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loading();
                      } else {
                        return Container(child:Text("Couldn't load image"));
                      }
                    })*/
                Container(
                    decoration: boxDecoration,
                    alignment: Alignment.topCenter,
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
            )));
  }
}

///extra code
/*Flexible(
         //         flex: 6,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton.icon(
                              onPressed: () async {
                                setState(() => buildRow("Bhaiii", "bhi"));
                              },
                              icon: Icon(Icons.import_contacts_rounded),
                              label: Text("See profiles")),
                          // 
                        ],
                        //ElevatedButton(child: Image(image: AssetImage()),)
                      ),
                    ),
                  )),
Expanded(
              flex: 3,
              child: Wrap(children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Container(
                    color: Colors.grey,
                    width: 700,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 500,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 100,
                          width: 300,
                          color: Colors.red,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              color: Colors.yellow,
                              height: 100,
                              width: 100,
                              child: RichText(
                                text: const TextSpan(
                                    text: " dog",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                          FontWeight.w700, //FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " See how much I've grown rat",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      )
                                    ]),
                              ),
                            )),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              color: Colors.green,
                              height: 100,
                              width: 100,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            1, 10, 10, 0),
                                        child: Icon(
                                          Icons.developer_mode_sharp,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '  Tinkle is Powered By:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            ),*/
