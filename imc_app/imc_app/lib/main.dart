import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC CALCULATOR"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person, size: 120.0, color: Colors.deepPurple),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Weight (kg)",
                labelStyle: TextStyle(color: Colors.lightBlue)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Height (cm)",
                labelStyle: TextStyle(color: Colors.lightBlue)),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
