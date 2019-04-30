//import 'package:firebase_database/firebase_database.dart';

class Producto{

  String _id;
  String _nombre;
  double _precio;
  String _descripcion;

  Producto (this._id, this._nombre, this._precio, this._descripcion);

  Producto.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._precio = obj['precio'];
    this._descripcion = obj['descripcion'];
  }
  
  String get id => _id;
  String get nombre => _nombre;
  double get precio => _precio;
  String get descripcion =>  _descripcion;
/*
  Producto.fromSnapShot(DataSnapshot snapshot){
    _id     = snapshot.key; 
    _nombre = snapshot.value['nombre'];
    _precio = snapshot.value['precio'];
    _descripcion = snapshot.value['descripcion'];
  }
*/
}