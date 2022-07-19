import 'package:flutter/material.dart';
//import 'package:bakerie_haven/screens/home/home.dart';
//import 'package:bakerie_haven/shared/constants.dart';

class SearchBar extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  //final Function search;
  SearchBar({
    Key? key,
    /*required this.search*/
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _searched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextFormField(
            //decoration: textInputDecoration,
          ),
          TextButton.icon(
              onPressed: () {
                setState(() {
                  _searched = true;
                  // widget.search(_searched);
                });
              },
              icon: Icon(Icons.search),
              label: Text('Search'))
        ],
      ),
    );
  }
}
