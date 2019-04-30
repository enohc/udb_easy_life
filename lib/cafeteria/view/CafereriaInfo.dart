import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CafeteriaInfo extends StatefulWidget{
  @override
  _CafeteriaInfo createState () => _CafeteriaInfo();
}

class _CafeteriaInfo extends State<CafeteriaInfo>{
  String nombre,descripcion, ubicacion;
    GlobalKey<FormState> _key = new GlobalKey();
    bool _autoValidacion = false;
    
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('UDB - Cafeteria'),
      ),
      body: SingleChildScrollView(
         child : Container(
          padding: EdgeInsets.all(15.0),
          child: new Form (
             key: _key,
             autovalidate: _autoValidacion,
             child: formUI(),
            ),
         ) 
      ),
    );
  }

  
   _saveToData(){
    //if(_key.currentState.validate()){
      DatabaseReference db = FirebaseDatabase.instance.reference();
      var data =  {
        "descripcion" : descripcion,
        "ubicacion"   : ubicacion,
        "productos"   : null 
      };
      db.child('CAFETERIA/$nombre').push().set(data).then((v){
        _key.currentState.reset();
      });
    /*}else{
      setState((){
        _autoValidacion = false;
      });
    }*/
   }

  String validateRequiereField(String field){
    return field.length == 0 ? 'El campo es requerido' : null;
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
        new RaisedButton(
             onPressed: _saveToData(),
             child: 
             new Icon(Icons.save),             
           )
      ],
    );
  
  }

  
}