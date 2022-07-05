// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:math';
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
                Test(curr: userDetails);
          } else {
            return Loading();
          }
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
  int _notifCount = 0;
  final shakeKey = GlobalKey<ShakeWidgetState>();
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

    final user = Provider.of<CurrentUser>(context);
    if (widget.curr == null) {
      return Container(child: Center(child: Text("details wanst retrieved")));
    }
    print("tyhe value we got was " +
        widget.curr.email +
        " /n You are a " +
        widget.curr.userType);
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
        body: _selectedScreenIndex == 0
            ? StreamProvider<List<Product>>.value(
                initialData: [], //was null,

                value: //_isQueried == false
                    widget.curr.userType == "customer"
                        ? DatabaseService(uid: user.uid).items
                        : DatabaseService(uid: user.uid).myItems, //expensive(),
                child: Scaffold(
                  drawer: NavBar(
                      widget.curr), // new Container(color: Colors.black),
                  backgroundColor: Color.fromARGB(255, 138, 59, 31),
                  appBar: AppBar(
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
                              delegate: MySearchDelegate(),
                            );
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      Expanded(
                        //Settings
                        flex: 2,
                        child: TextButton.icon(
                            onPressed: () {
                              _showSettingsPanel();
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Color.fromARGB(255, 230, 230, 230),
                            ),
                            label: Text("Settings")),
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
                  body: Column(children: [
                    // Text(widget.curr.),
                    ProductsList(
                      details: widget.curr,
                    ),
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
            : Dashboard());
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    // throw UnimplementedError();
    [
      //clears all the text in search
      IconButton(
          onPressed: () {
            if (query == '')
              close(context, null);
            else
              query = '';
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
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
    // throw UnimplementedError();
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
            title: Text(suggestion),
          );
        });
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
abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
      AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    required this.shakeOffset,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
  }) : super(key: key);
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 1. return an AnimatedBuilder
    return AnimatedBuilder(
      // 2. pass our custom animation as an argument
      animation: animationController,
      // 3. optimization: pass the given child as an argument
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          // 4. apply a translation as a function of the animation value
          offset: Offset(sineValue * widget.shakeOffset, 0),
          // 5. use the child widget
          child: child,
        );
      },
    );
  }
}
