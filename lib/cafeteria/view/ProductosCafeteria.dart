import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udb_easy_life/cafeteria/model/Cafeteria.dart';
import 'package:udb_easy_life/cafeteria/model/Producto.dart';

class ProductosCafetereria extends StatefulWidget{
  final Cafeteria cafeteria;
  ProductosCafetereria(this.cafeteria);
  @override
    _ProductosCafetereria createState() => _ProductosCafetereria(cafeteria);
}

class _ProductosCafetereria extends State<ProductosCafetereria>{

  Cafeteria cafeteria;
  List<Producto> productos = new List();
  _ProductosCafetereria(this.cafeteria);

   @override
  void initState(){
    super.initState();
    DatabaseReference db = FirebaseDatabase.instance.reference();
    db.child('CAFETERIA/${cafeteria.nombre}/productos').once().then((DataSnapshot snap) async{
      var keys = snap.value.keys;
      var data = snap.value;
      for(var key in keys){
        Producto producto = new Producto(null,key, data[key]['precio'], data[key]['descripcion'] );
        productos.add(producto);
        print(key);
      }
    });
  }
  
  Widget _ui(){
    return Column(
      children: <Widget>[
        new Container(
          child: Column(
            children: <Widget>[  
            Image.asset('images/no_imagen.png', width: 370,),
            ListTile(
              title: Text('${cafeteria.nombre}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              subtitle: Text('${cafeteria.descripcion}'),
            ),
            ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, id){
                return Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text('${productos[id].nombre}'),
                          Text('${productos[id].precio}'),
                        ],
                      ),
                    )
                  ],
                );
              },
              
            )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prouctos Caferia '),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Text("data"),
        ),
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
    );
  }
  

}
