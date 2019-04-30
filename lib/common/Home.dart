import 'package:flutter/material.dart';
import 'package:udb_easy_life/cafeteria/view/CafeteriaLista.dart';
import 'dart:developer';

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    RaisedButton _button(String label){
      log(label);
      return RaisedButton(
        onPressed: (){
          switch (label){
            case 'BOOKART':{
              _navigatorToCafeterias(context);
            }
            break;
            case 'CAFETERIA':{
              _navigatorToCafeterias(context);
            }            
            break;
          }
        },
        textColor: Colors.white,
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(0.0),
        child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
      );
    }

    return MaterialApp(
      title: 'UDB Easy life',
      home: Scaffold(
        body: ListView(
          children:[
            Image.asset(
              'images/udbPlus_easy_life.png',
              height: 300,
              fit: BoxFit.scaleDown,
            ),
            Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _button('BOOKART'),
          _button('CAFETERIA'),         
        ],
      ),
            )
          ],
        ),
        persistentFooterButtons: <Widget>[
          Image.asset(
              'images/Universidad_don_bosco.jpg',
              height: 50.0,
            ),
            Divider(),
            Image.asset(
              'images/EDGI.jpeg',
              height: 50.0,
            ),
        ],
      ),
    );
  }

  void _navigatorToCafeterias(BuildContext context) async{
    await Navigator.push(context, 
      MaterialPageRoute(builder: (context) => CafeteriaLista(),
      )
    );
  }

}