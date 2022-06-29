import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bakerie_haven/models/product.dart';

class NavBar extends StatefulWidget {
  CurrentLoginDetails? details;
  NavBar(this.details);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: RichText(
              // accountEmail: "".
              text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'BAKERIE',
                      style: TextStyle(
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
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.details!.userType == "customer"
                      ? AssetImage("users/customer.png")
                      : AssetImage("users/supplier.png")),
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
    );
  }
}
