import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bakerie_haven/models/product.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:bakerie_haven/screens/home/settings_form.dart';

class NavBar extends StatefulWidget {
  final CurrentLoginDetails details;
  //String name;
  CustData? cust;
  SupplierData? sup;
  NavBar(this.details);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      //this is a built in flutter widget fucntion
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(details: widget.details),
            );
          });
    }

    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(35)),
          child: Drawer(
            // shape: ShapeBorder.lerp(a, b:ShapeBorder()., t:0.6)
            backgroundColor: Color.fromARGB(255, 230, 230, 230),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
              child: ListView(
                // Remove padding
                padding: EdgeInsets.fromLTRB(0, 2, 2, 10),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: UserAccountsDrawerHeader(
                      currentAccountPictureSize: Size.fromRadius(30),
                      arrowColor: Colors.black,
                      accountName: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Text(
                          widget.details.userType,
                          style: TextStyle(color: Colors.purpleAccent),
                        ),
                      ),
                      accountEmail: Text(widget.details.email,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Tahoma",
                          )),
                      currentAccountPicture: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 230, 230, 230),
                          child: ClipOval(
                            child: widget.details.userType == "supplier"
                                ? Image.network(
                                    'https://static.vecteezy.com/system/resources/thumbnails/003/126/397/small/line-icon-for-deliverable-vector.jpg')
                                : Image.network(
                                    'https://w1.pngwing.com/pngs/726/597/png-transparent-graphic-design-icon-customer-service-avatar-icon-design-call-centre-yellow-smile-forehead.png'),
                            //  fit: BoxFit.cover,
                            //  width: double.infinity,
                            //  height: double.infinity // 200,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(

                          // color: Colors.pinkAccent,

                          ///fromARGB(255, 230, 230, 230),
                          shape: BoxShape.circle),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () => null,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Feedback'),
                    onTap: () => _showSettingsPanel(),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Exit'),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () => defaultTargetPlatform == TargetPlatform.android
                        ? SystemNavigator.pop()
                        : exit(0),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  //@override
  //Size get preferredSize => const Size.fromHeight(56.0);
}
