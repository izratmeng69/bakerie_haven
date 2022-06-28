import 'package:flutter/material.dart';
import 'dart:io';

class NavBar extends StatelessWidget {
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
                  image: AssetImage('assets/images/logosplash.png'),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            /*decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/logosplash.png")),
            ),*/
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
