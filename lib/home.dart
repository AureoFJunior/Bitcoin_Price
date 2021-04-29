import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String price = "";

  void getPrice() async {

    String url = "https://blockchain.info/ticker";
    http.Response getter = await http.get(url);

    Map<String, dynamic> resultado = json.decode(getter.body);

    setState(() {
      price = resultado["BRL"]["buy"].toString();
    });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("resources/bitcoin.png"),
                Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: Text("R\$ " + price, style: TextStyle(fontSize: 20),),
                ),
                ElevatedButton(
                  child: Text("Refresh",
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () => getPrice(),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
