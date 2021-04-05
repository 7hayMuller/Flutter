import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home:Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    }) ;
  }

  final _toDoController = TextEditingController();
  List _toDoList = [];

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = '';
      newToDo['ok'] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('𝕄𝕪 𝕋𝕠 𝔻𝕠 𝕃𝕚𝕤𝕥'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body:Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0,1.0,7.0,1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color:Colors.greenAccent)
                      )
                  ),
                ),
                RaisedButton(
                  color:Colors.greenAccent,
                  child: Text('+'),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                )
              ],
            ),
          ),
          Expanded(
            child:ListView.builder(
              padding:EdgeInsets.only(top:10.0),
              itemCount: _toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_toDoList[index]['title']),
                  value: _toDoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(_toDoList[index]['ok'] ? Icons.check : Icons.error),
                  ),
                  onChanged:(checked) {
                    setState((){
                    _toDoList[index]['ok'] = checked;
                    _saveData();
                    });
                  }
                );
              }),

          )

        ],
      )
    );
  }

  //Function to get a file
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  //Function to save data on the file
  Future<File> _saveData() async {

    String data = json.encode(_toDoList);
    final file =  await _getFile();
    return file.writeAsString(data);
  }

  //Function to read data from the file
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch(e) {
      return null;
    }
  }
}






