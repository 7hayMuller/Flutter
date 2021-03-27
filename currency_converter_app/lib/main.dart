import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=a100d601";

void main() async {

  runApp(MaterialApp(
    home:Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double dollar;
  double euro;

  void _realChanged(String text) {
    if(text.isEmpty){
      _clearAll();
      return;
    }
   double real = double.parse(text);
   dollarController.text = (real/dollar).toStringAsFixed(2);
   euroController.text = (real/euro).toStringAsFixed(2);

  }
  void _dollarChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double dollar = double.parse(text);
    realController.text = (dollar*this.dollar).toStringAsFixed(2);
    euroController.text = (dollar*this.dollar / euro).toStringAsFixed(2);
  }
  void _euroChanged(String text){
    if(text.isEmpty){
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro*this.euro).toStringAsFixed(2);
    dollarController.text = (euro*this.euro / dollar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = '';
    dollarController.text = '';
    euroController.text = '';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text('Cᴜʀʀᴇɴᴄʏ Cᴏɴᴠᴇʀᴛᴇʀ',
        style: TextStyle(
          fontSize:25.0,
          color:Colors.black45
        )),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context , snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text('𝙻𝚘𝚊𝚍𝚒𝚗𝚐 ...',
                   style: TextStyle(
                  color: Colors.amber,
                  fontSize:25.0
              ),
                      textAlign: TextAlign.center,
                  ),
            );
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text('𝙴𝚁𝚁𝙾 :(',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize:25.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dollar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150.0, color:Colors.amber),
                      Divider(),
                      buildTextField('𝙱𝚛𝚊𝚣𝚒𝚕𝚒𝚊𝚗 𝚁𝚎𝚊𝚕', 'R\$' , realController , _realChanged),
                      Divider(),
                      buildTextField('𝙳𝚘𝚕𝚕𝚊𝚛', 'US\$' , dollarController , _dollarChanged),
                      Divider(),
                      buildTextField('𝙴𝚞𝚛𝚘', '€' , euroController, _euroChanged),
                    ],
                  )
                );


              }
          }
        }),
    );
  }
}

Widget buildTextField(String label , String prefix , TextEditingController controller , Function changeText) {
  return
    TextField(
      controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color:Colors.amber),
            border:OutlineInputBorder(),
            prefixText:prefix,
        ),
        style: TextStyle(
            color:Colors.amber, fontSize: 20.0
        ),
        onChanged: changeText,
        keyboardType: TextInputType.number,
    );

}





