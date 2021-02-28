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
  TextEditingController weighController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Please enter your data';

  void _resetFields() {
    weighController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Please enter your data';
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weighController.text);
      double height = double.parse(heightController.text) / 100;

      double bmi = weight / (height * height);

      if (bmi < 18.6) {
        _infoText =
            "Your weight is below the recommended, your BMI is ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Ideal weight, your BMI is ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText =
            "slightly overweight, your BMI is ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Obesity I, your BMI is ${bmi.toStringAsPrecision(4)}";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "Obesity II , your BMI is ${bmi.toStringAsPrecision(4)}";
      } else if (bmi > 40.0) {
        _infoText = "Obesity III , your BMI is ${bmi.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI CALCULATOR"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person, size: 120.0, color: Colors.deepPurple),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Weight (kg)",
                        labelStyle: TextStyle(color: Colors.lightBlue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                    controller: weighController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insert your weight";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Height (cm)",
                        labelStyle: TextStyle(color: Colors.lightBlue)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insert your height";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text('Calculate',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0)),
                          color: Colors.deepPurple),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
