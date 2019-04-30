import 'package:flutter/material.dart';


class CafeteriaInfo extends StatefulWidget{
  @override
  _CafeteriaInfo createState () => _CafeteriaInfo();
}

class _CafeteriaInfo extends State<CafeteriaInfo>{
  String nombre,descripcion, ubicacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UDB - Cafeteria'),
      ),
      body: Column(
         children: <Widget>[
           formUI()
         ], 
      ),
    );
  }

  
  Widget formUI(){
    return Column(
      children: <Widget>[
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Nombre de la cafereria'),
          onSaved: (val){
            nombre = val;
          },
          
          maxLength: 50,
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Descripcion'),
          onSaved: (val){
            descripcion = val;
          },
          maxLength: 250,
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Ubicacion'),
          onSaved: (val){
            ubicacion = val;
          },
          maxLength: 200,
        ),
      ],
    );
  }

  _saveToData(){
    
  }
}