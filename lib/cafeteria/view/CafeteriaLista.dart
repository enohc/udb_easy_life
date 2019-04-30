import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udb_easy_life/cafeteria/model/Cafeteria.dart';
import 'package:udb_easy_life/cafeteria/view/CafereriaInfo.dart';
import 'package:udb_easy_life/cafeteria/view/ProductosCafeteria.dart';

class CafeteriaLista extends StatefulWidget {
  @override
  _CafeteriaLista createState() => _CafeteriaLista();
}



class _CafeteriaLista extends State<CafeteriaLista> {
  
  //final tbl = FirebaseDatabase.instance.reference().child('CAFETERIA');
  List<Cafeteria> items = new List();
  
    
  @override
  void initState(){
    super.initState();
    DatabaseReference db = FirebaseDatabase.instance.reference();
    db.child('CAFETERIA').once().then((DataSnapshot snap) async{
      var keys = snap.value.keys;
      for(var key in keys){
        Cafeteria cafeteria = new Cafeteria(null, key, null, null);
        items.add(cafeteria);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(      
     appBar: AppBar(
        title: Text("UDB - Cafeterias",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body:items.length == 0 ? Text ('No hay registros que mostrar.') :  ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              Divider(height: 1.0),
              Container(
                padding: EdgeInsets.all(3.0),
                child: Card(
                  child: Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child:'${items[index].ubicacion}' == ''
                                  ? Image.asset('images/no_imagen.png',
                                    fit: BoxFit.fill,
                                    height: 70.0,
                                  )
                                  :  Image.asset('images/no_imagen.png',
                                    fit: BoxFit.fill,
                                    height: 70.0,
                                  )/*Image.network(
                                      '${items[index].nombre}' + '?alt=media',
                                      fit: BoxFit.fill,
                                      height: 70.0,
                                      width: 57.0,
                                  )*/,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('${items[index].nombre}', style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold

                            ),
                            ),
                          subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur quis turpis eleifend, pharetra justo a, sagittis diam. Etiam purus purus, vestibulum vitae faucibus at, volutpat vel velit.'),
                          onTap: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ProductosCafetereria(items[index]),),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Cafeterias"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text('Crear Cafeteria'),
              onTap: (){
                //Navigator.pop();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => CafeteriaInfo())
               );
              },
            )
          ],
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