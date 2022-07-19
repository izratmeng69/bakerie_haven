/*import 'package:flutter/material.dart';

class ScaffActions extends StatefulWidget {
  const ScaffActions({super.key});

  @override
  State<ScaffActions> createState() => _ScaffActionsState();
}

class _ScaffActionsState extends State<ScaffActions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  delegate: MySearchDelegate(widget.curr, context),
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
                    if (_notifCount == 0) shakeKey.currentState?.shake();
                    // Scaffold.of(context).openDrawer();
                  },
                ),
              ) /**/
              ),
        ],
      ), //actions inappbar expects widgetlist of buttons),
    );
  }
}/*Flexible(
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
*/