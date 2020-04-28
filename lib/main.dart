import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('ListViews')),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

// replace this function with the code in the examples
Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/sun.jpeg'),
        ),
        title: Text('Sun'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/moon.jpeg'),
        ),
        title: Text('Moon'),
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/stars.jpeg'),
        ),
        title: Text('Star'),
      ),
    ],
  );
}
