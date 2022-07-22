// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart'; //for checking playfprm code
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; //picking files and streams
import 'package:bakerie_haven/Services/auth.dart';

import 'package:bakerie_haven/screens/authenticate/authenticate.dart';
import 'package:bakerie_haven/screens/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; //for options

import 'package:bakerie_haven/models/models.dart.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:bakerie_haven/screens/home/location_dashboard.dart';

//import 'package:sliver_tools/sliver_tools.dart';
//shared variables
//import 'package:shared_preferences/shared_preferences.dart';
//encryption
//import 'package:flutter_string_encryption/flutter_string_encryption.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:bakerie_haven/shared/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (defaultTargetPlatform == TargetPlatform.android) {
// Android specific code

  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  } else {
//web or desktop specific code
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  int _counter = 0;
  //final counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    //CurrentUser curr = CurrentUser(uid: "1");
    //wrap material app with streamrpovider that changes app
    //depending on changesin the authentication service -lo/sinout/in
    return StreamProvider<CurrentUser?>.value(
        initialData: null,
        //variable curr wascreated

        value: AuthService().user, //stream to listen to
        child: MaterialApp(
          theme: theme(),
          home:
              Wrapper(), //), //Dashboard()), //Wrapper()), //SeeMoreDropDown()), //
        ));
  }
}

//extra code deleted
class SeeMoreDropDown extends StatefulWidget {
  const SeeMoreDropDown({Key? key}) : super(key: key);

  @override
  State<SeeMoreDropDown> createState() => _SeeMoreDropDownState();
}

class _SeeMoreDropDownState extends State<SeeMoreDropDown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //see more drop down menu
          ExpansionTile(
            title: Text("See more"),
            leading: Icon(Icons.info),
            children: [
              ListTile(
                title: Text("First"),
              ),
              ListTile(
                title: Text("Second"),
              ),
              ListTile(
                title: Text("Third"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//unfinishd datepicker- time10:00 ojn video
class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//unfinished timepicker
class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BottomNavBar extends StatefulWidget {
  //const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.menu),
    Icon(Icons.person)
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: body[_currentIndex],
        ), //BottomNavBar()),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ], currentIndex: _currentIndex));
  }
}

class PageViewer extends StatefulWidget {
  const PageViewer({Key? key}) : super(key: key);

  @override
  State<PageViewer> createState() => _PageViewerState();
}

//2 classes for page sliding
class _PageViewerState extends State<PageViewer> {
  PageController controller = PageController();

  int _curr = 0;
  List<Widget> _list = <Widget>[
    new Center(
        child: new Pages(
      text: "Page 1",
    )),
    new Center(
        child: new Pages(
      text: "Page 2",
    )),
    new Center(
        child: new Pages(
      text: "Page 3",
    )),
    new Center(
        child: new Pages(
      text: "Page 4",
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: _list,
          scrollDirection: Axis.horizontal,

          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num) {
            setState(() {
              _curr = num;
            });
          },
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _list.add(
                        new Center(
                            child: new Text("New page",
                                style: new TextStyle(fontSize: 35.0))),
                      );
                    });
                    if (_curr != _list.length - 1)
                      controller.jumpToPage(_curr + 1);
                    else
                      controller.jumpToPage(0);
                  },
                  child: Icon(Icons.add)),
              FloatingActionButton(
                  onPressed: () {
                    _list.removeAt(_curr);
                    setState(() {
                      controller.jumpToPage(_curr - 1);
                    });
                  },
                  child: Icon(Icons.delete)),
            ]));
  }
}

class Pages extends StatelessWidget {
  Pages({this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}

//this widgets makes top title go up as we scroll down,mperfect for profiles or items

