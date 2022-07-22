import 'package:bakerie_haven/Services/firebase_api_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

//import 'package:bakerie_haven/models/';
class Dashboard extends StatefulWidget {
  // const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //location coordinates
  var locationMessage = "";
  final database = FirebaseDatabase.instance.ref();

  //final Geolocator geo = Geolocator();
  Future<void> getCurrentLocation() async {
    // Future<Position?> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      var position =
          Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      var lastPosition = Geolocator.getLastKnownPosition();
      print(lastPosition);
      setState(() {
        locationMessage = "$position.latitude, $position.longtitude";
      });
      print(locationMessage);
      //throw Exception('Error');
    }
    // return await Geolocator.getCurrentPosition();
    //}
  }

  @override
  Widget build(BuildContext context) {
    final livedata = database.child('/live');
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Icon(Icons.location_on, size: 50, color: Colors.green),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text("Get user location"),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: Text("Get Current location"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            )
          ],
        ),
      ),
    );
  }
}
