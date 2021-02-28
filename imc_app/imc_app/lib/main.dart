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
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
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
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                      onPressed: () {},
                      child: Text('Calculate',
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                      color: Colors.deepPurple),
                ),
              ),
              Text(
                "Info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
              )
            ],
          ),
        ));
  }
}
