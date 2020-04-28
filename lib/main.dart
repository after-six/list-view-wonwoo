import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListViews',
      theme: ThemeData(
        primarySwatch: Colors.primaries[13],
        secondaryHeaderColor: Colors.primaries[13],
      ),
      home: BodyLayout(),
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
  bool isSendDisable = true;

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
    return Scaffold(
      appBar: AppBar(title: Text('After Todos')),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SafeArea(
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
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'What to do?',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.black,
                        controller: _textController,
                        focusNode: todoInputFocusNode,
                        onSubmitted: !isSendDisable ? _insertSingleItem : null,
                        onChanged: (text) => setState(() {
                          isSendDisable = text.length > 0 ? false : true;
                        }),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () => !isSendDisable ? _insertSingleItem(_textController.text) : null,
                        icon: Icon(
                          Icons.send,
                          color: isSendDisable ? Colors.black12 : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
    _data.insert(0, text);
    _listKey.currentState.insertItem(0);
    todoInputFocusNode.requestFocus();

    setState(() {
      isSendDisable = true;
    });
  }

  void _removeSingleItem(index) {
    String removedItem = _data.removeAt(index);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, index, animation);
    };

    _listKey.currentState.removeItem(index, builder);
  }
}
