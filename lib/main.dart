import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('After Todos')),
        backgroundColor: Colors.deepPurple,
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() => BodyLayoutState();
}

class BodyLayoutState extends State<BodyLayout> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  List<String> _data = [];
  FocusNode todoInputFocusNode;

  @override
  void initState() {
    super.initState();
    todoInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    todoInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Flexible(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _data.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_data[index], index, animation);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'What to do?',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      cursorColor: Colors.white,
                      controller: _textController,
                      focusNode: todoInputFocusNode,
                      onSubmitted: _insertSingleItem,
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () => _insertSingleItem(_textController.text),
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String item, int index, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            '${(index + 1).toString()}. $item',
            style: TextStyle(fontSize: 20),
          ),
          onLongPress: () => _removeSingleItem(index),
        ),
      ),
    );
  }

  void _insertSingleItem(text) {
    _textController.clear();
    todoInputFocusNode.requestFocus();

    if (text.length < 1) {
      return;
    }

    _data.insert(0, text);
    _listKey.currentState.insertItem(0);
  }

  void _removeSingleItem(index) {
    String removedItem = _data.removeAt(index);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, index, animation);
    };

    _listKey.currentState.removeItem(index, builder);
  }
}
