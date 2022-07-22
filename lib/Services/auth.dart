import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:bakerie_haven/Services/database.dart';
import 'package:bakerie_haven/models/models.dart.dart';

/*FirebaseUser has been changed to User

    AuthResult has been changed to UserCredential

    GoogleAuthProvider.getCredential() has been changed to GoogleAuthProvider.credential()

    onAuthStateChanged which notifies about changes to the user's sign-in state was replaced with authStateChanges()

    currentUser() which is a method to retrieve the currently logged in user, was replaced with the property currentUser and it no longer returns a Future<FirebaseUser> */
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object based onfirebase user
  CurrentUser? _userFromFirebaseuser(User? user) {
    if (user != null) return CurrentUser(uid: user.uid);
    return null;
  } //based on my CurrentUserclassI created

  Stream<CurrentUser?> get user {
    //monitors the change in auth and send the stream tomain
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseuser(user));
        .map(_userFromFirebaseuser); //these 2 statementsexactly the same
  }

  Future signInAnon() async {
    try {
      UserCredential userCred = await _auth.signInAnonymously();
      User user = userCred.user!;
      /*DatabaseReference ref = FirebaseDatabase.instance
          .ref("users/123"); //no path points to root of database
      DatabaseReference child = FirebaseDatabase.instance.ref("users/123/");
      return child.toString();*/
      return _userFromFirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCred.user!;
      return _userFromFirebaseuser(
          user); //can also return data for user like uidor username
    } catch (e) {
      e.toString();
      return null;
    }
  }

  Future registerEmailPassword(
      //now finish sign in
      String email,
      String password,
      String type,
      String url) async {
    if (type == "customer") {
      print("we are registering customer...");
      try {
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = userCred.user!;

        //create new document using id given byy firebase auth
        await DatabaseService(uid: user.uid)
            .updateCustData("Customer", 20, "SFO", "customer");
        await DatabaseService(uid: user.uid).updateUserData(
          email,
          password,
          type,
        );

        return _userFromFirebaseuser(user);
      } catch (e) {
        print(e.toString() + "Maybe your user type is incorrect");
        return null;
      }
    } else if (type == "supplier") {
      try {
        print("we are registering supplier...");
        UserCredential userCred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User user = userCred.user!;

        //create new document using id given byy firebase auth
        await DatabaseService(uid: user.uid)
            .updateSupplierUserData(email, "UserOne", "SanDo", url,0);
        await DatabaseService(uid: user.uid).updateUserData(
          email,
          password,
          type,
        );
        return _userFromFirebaseuser(user);
      } catch (e) {
        print(e.toString() + "Maybe your user type is incorrect");

        return null;
      }
    } else
      print(" rat boy you have an wrong userType!");
  }

  Future signOut() async {
    try {
      return await _auth.signOut(); //built in authsign out
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }
}
