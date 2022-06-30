import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bakerie_haven/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatefulWidget {
  CurrentLoginDetails? details;
  NavBar(this.details);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(
          // shape: ShapeBorder.lerp(a, b:ShapeBorder()., t:0.6)
          backgroundColor: Colors.pinkAccent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 10, 20),
            child: ListView(
              // Remove padding
              padding: EdgeInsets.all(12),
              children: [
                
                UserAccountsDrawerHeader(
                  accountName: RichText(
                    // accountEmail: "".
                    text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Caveat',
                          color: Colors.red,
                          fontSize: 16.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'BAKERIE',
                            style: TextStyle(
                              backgroundColor: Colors.red,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(-1.0, 1.0),
                                    color: Colors.white),
                                Shadow(
                                    // bottomRight
                                    offset: Offset(1.0, -1.0),
                                    color: Colors.white),
                                Shadow(
                                    // topRight
                                    offset: Offset(-1.0, -1.0),
                                    color: Colors.white),
                                Shadow(
                                    // topLeft
                                    offset: Offset(1.0, 1.0),
                                    color: Colors.white),
                              ],
                              color: Colors.orange[400],
                            ),
                          ),
                        ]),
                  ),
                  accountEmail: Text('trial course',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Tahoma",
                      )),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        image: widget.details!.userType == "supplier"
                            ? NetworkImage(
                                'https://static.vecteezy.com/system/resources/thumbnails/003/126/397/small/line-icon-for-deliverable-vector.jpg')
                            : NetworkImage(
                                'https://w1.pngwing.com/pngs/726/597/png-transparent-graphic-design-icon-customer-service-avatar-icon-design-call-centre-yellow-smile-forehead.png'),
                        fit: BoxFit.fitHeight,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://w1.pngwing.com/pngs/726/597/png-transparent-graphic-design-icon-customer-service-avatar-icon-design-call-centre-yellow-smile-forehead.png')),
                      color: Color.fromARGB(255, 230, 230, 230),
                      shape: BoxShape.circle),
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
                  onTap: () => null,
                ),
                Divider(),
                ListTile(
                  title: Text('Exit'),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () => exit(0),
                ),
              ],
            ),
          ),
        ));
  }
}
