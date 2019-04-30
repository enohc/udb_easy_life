//import 'package:firebase_database/firebase_database.dart';


class Cafeteria{

  String _id;
  String _nombre;
  String _descripcion;
  String _ubicacion;

  Cafeteria(this._id, this._nombre, this._descripcion,this._ubicacion);
  
  Cafeteria.map(dynamic obj){
     this._nombre       = obj['nombre']; 
     this._descripcion  = obj['descripcion'];
     this._ubicacion    = obj['ubicacion'];
  }

  String get id          => _id;
  String get nombre      => _nombre;
  String get descripcion => _descripcion;
  String get ubicacion   => _ubicacion;
/*
  Cafeteria.fromSnapShot(DataSnapshot snapshot){
     _id          = snapshot.key;
     _nombre      = snapshot.value['nombre'];
     _descripcion = snapshot.value['descripcion'];
     _ubicacion   = snapshot.value['ubicacion'];
  }*/
}