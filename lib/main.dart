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
        leading: Icon(Icons.wb_sunny),
        title: Text('Sun'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: Icon(Icons.brightness_3),
        title: Text('Moon'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: Text('Star'),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    ],
  );
}
