import 'package:bakerie_haven/blocs/todos/todos_bloc.dart';
import 'package:bakerie_haven/blocs/todos/todos.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:bakerie_haven/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakerie_haven/screens/home/home.dart';
import 'package:bakerie_haven/screens/authenticate/authenticate.dart';
import 'package:bakerie_haven/models/currentuser.dart';
//import 'package:bakerie_haven/shared/session.dart';
//import 'autoLogin.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:bakerie_haven/Services/auth.dart';

class Wrapper extends StatefulWidget {
  // const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _auth = AuthService();

  bool loading = false;
  bool _found = false;

  @override
  void initState() {
    // getVal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    if (user == null || user == "") {
      //getVal(prefs);
      //so we create a user, by asking their choice, on that screen, we check for existing login data so we sign in, else, we just update
      //preferences when they choose,and then we send that data to authenticate screen

      //if data exists, and we sign in, we'll be redirected to home page

      //
      // found = true;

      return Authenticate();
    } else
      return Home();
  } //

  Widget AutoLogin(
      BuildContext context /*, Future<String> email, Future<String> type*/) {
    Widget CancleButton =
        InkWell(child: TextButton(onPressed: () {}, child: Text("cancel")));
    return Scaffold(
        body: Center(child: Text("ia am loggin in automatically ")));
  }
}

/*class TestWidgets extends StatelessWidget {
  //const TestWidgets({super.key});
  List<Todo> todos = [
    Todo(id: '1', task: 'Sample Todo', description: 'This is a test To Do'),
    Todo(id: '1', task: 'Sample Todo', description: 'This is a test To Do'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Pattern With Database'), actions: [
        IconButton(
            onPressed: () {
              //move to add to-do widget
              MaterialPageRoute(builder: (context) => TestDatabase());
            },
            icon: Icon(Icons.plus_one)),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return _ToDoCard(todos[index]);
                  }),
            ),
            //returning todo card widget
          ],
        ),
      ),
    );
  }

  Card _ToDoCard(Todo todo) {
    return Card(
      child: Text(todo.description),
    );
  }
}

class TestDatabase extends StatefulWidget {
  const TestDatabase({super.key});

  @override
  State<TestDatabase> createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing bloc and real time database'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /* Container(
              child: Text('Test Database Screen'),
            ),*/
            TextButton.icon(
                onPressed: () {
                  MaterialPageRoute(builder: ((context) => ReadDatabase()));
                },
                icon: Icon(Icons.read_more),
                label: Text('Read examples')),
            TextButton.icon(
                onPressed: () {
                  MaterialPageRoute(builder: ((context) => WritingDatabase()));
                },
                icon: Icon(Icons.read_more),
                label: Text('Write examples'))
          ],
        ),
      ),
    );
  }
}

class ReadDatabase extends StatefulWidget {
  const ReadDatabase({super.key});

  @override
  State<ReadDatabase> createState() => _ReadDatabaseState();
}

class _ReadDatabaseState extends State<ReadDatabase> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Reading from database'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Testing the database'),
          )
        ],
      ),
    ));
  }
}

class WritingDatabase extends StatefulWidget {
  const WritingDatabase({super.key});

  @override
  State<WritingDatabase> createState() => _WritingDatabaseState();
}

class _WritingDatabaseState extends State<WritingDatabase> {
  final database = FirebaseDatabase.instance.ref(); //points to top of the tree

  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('dialySpecial');
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Writing to database'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Testing the database'),
          ),
          ElevatedButton.icon(
              onPressed: () {
                dailySpecialRef
                    .set({'itemid': 'user1id', 'price': '20.00'}).then(
                        (value) =>
                            print('Special has been written to database'));
              },
              icon: Icon(Icons.pages),
              label: Text('Write')),
        ],
      ),
    ));
  }
}*/
