import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/screens/home/home.dart';
import 'package:bakerie_haven/screens/authenticate/authenticate.dart';
import 'package:bakerie_haven/models/currentuser.dart';
//import 'package:bakerie_haven/shared/session.dart';
//import 'autoLogin.dart';
import 'authenticate/authenticate.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:bakerie_haven/Services/auth.dart';

class Wrapper extends StatefulWidget {
  // const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _auth = AuthService();
  //SessionManager prefs = SessionManager();
  bool loading = false;
  bool _found = false;

  /*if (!prefs.containsKey(
            'email') //('type') != null&& sharedPreferences!.getString('id') != )
        ) {
     
      prefs.setString('email', "joshuabridgemohan966@gmail.com");
      prefs.setString('pw', "ilovefood69"); prefs.setString('id', "mKsnn6UNRLWINz4evY7IOm3BAr32");
      prefs.setString('type', "customer");
      setState(() {
        type = "unknown";
        id = "guest";
        email = "none";
        pw = "pass";
      });

      print(email + "was found and printed from shareedpreferences ");
    } else {
      setState(() {
        type = prefs
            .getString('type')!; //watch where the exclamation mark is
        email = prefs.getString('email')!;
        id = prefs.getString('id')!;
      });
    }
  }*/

  @override
  void initState() {
    // getVal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SharedPreferences? prefs;
    //getVal(prefs!);
    //print(" im getting my prefs again");
    //prefs.clearPrefs();

    //Future<String> type = prefs.getType();
    //prefs.setEmail("iluvwendy99@gmail.com");
    /*Future<String> email;
    Future<String> pw;
    Future<String> type = email = prefs.getEmail();
    if (email == "iluvwendy99@gmail.com") {
      setState(() {
        _found = true;
      });
    }*/

    final user = Provider.of<CurrentUser?>(context);

    if (user == null || user == "") {
      //getVal(prefs);
      //so we create a user, by asking their choice, on that screen, we check for existing login data so we sign in, else, we just update
      //preferences when they choose,and then we send that data to authenticate screen

      //if data exists, and we sign in, we'll be redirected to home page

      // print("we are in wrapper file,and didnt find a user");
      /* if (_found == false) {
        //
        // found = true;
        print("we  didnt fix prefs");*/
      return Authenticate(); //Authenticate();
    } //else {
    /* print("we got email toload from prefs");
        return AutoLogin(
          context,
          //email,
          //type,
        );
      }
      //autologsin-send emailn pw
    }*/
    else
      //print(" home is being printed..getting shared prefsagain ");
      // getVal();
      // print("autologging inl...");
      return Home();
    //send id and usertype
  } // RAT BOY - JUST ADD GETVALPREFERENCES TO GET VALUES TO SEND TO HOME

  Widget AutoLogin(
      BuildContext context /*, Future<String> email, Future<String> type*/) {
    Widget CancleButton =
        InkWell(child: TextButton(onPressed: () {}, child: Text("cancel")));
    return Scaffold(
        /*appBar: AppBar(
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [PopupMenuItem(child: Text(""))])
          ],
          /*iconTheme:   IconTheme(data: IconThemeData(color: Colors.red, opacity: 1.0,size: 12.0),),),child: Text('m'),);*/
          title: Text("Bakerie"),
        ),*/
        body: Center(child: Text("ia am loggin in automatically ")));
  }
}
