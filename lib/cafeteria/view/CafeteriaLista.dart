import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udb_easy_life/cafeteria/model/Cafeteria.dart';
import 'package:udb_easy_life/cafeteria/view/CafereriaInfo.dart';
import 'package:udb_easy_life/cafeteria/view/ProductosCafeteria.dart';

class CafeteriaLista extends StatefulWidget {
  @override
  _CafeteriaLista createState() => _CafeteriaLista();
}

final tbl = FirebaseDatabase.instance.reference().child('CAFETERIA');

class _CafeteriaLista extends State<CafeteriaLista> {
  
  //final tbl = FirebaseDatabase.instance.reference().child('CAFETERIA');
  List<Cafeteria> items = new List();
  StreamSubscription<Event> _onCafeteriaAddedSubscription;
  StreamSubscription<Event> _onCafeteriaChangedSubscription; 
    
  @override
  void initState(){
    super.initState();
    items = new List();
    _onCafeteriaAddedSubscription =  tbl.onChildAdded.listen(_onCaferiaAdded);
    _onCafeteriaChangedSubscription = tbl.onChildChanged.listen(_onCaferiaUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onCafeteriaAddedSubscription.cancel();
    _onCafeteriaChangedSubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products List'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,          
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),                    
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(                      
                        child: Row(
                          children: <Widget>[
                            //nuevo imagen
                             /*new Container( 
                              padding: new EdgeInsets.all(5.0),                          
                              child: '${items[position].productImage}' == ''
                                  ? Text('No image')
                                  : Image.network(
                                      '${items[position].productImage}' +
                                          '?alt=media',
                                          fit: BoxFit.fill,
                                      height: 57.0,
                                      width: 57.0,
                                    ),
                             ),*/
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].nombre}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].descripcion}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  onTap: () => _navigateToProductInformation(
                                      context, items[position])),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _showDialog(context, position),
                                ),
                                
                            //onPressed: () => _deleteProduct(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () =>
                                    _navigateToProduct(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () => _createNewProduct(context),
        ),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.purple,
                ),
                onPressed: () =>
                  _deleteCafeteria(context, items[position], position,),                                        
                    ),                   
            new FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//_onCaferiaAdded Caferia
  void _onCaferiaAdded(Event event) {
    setState(() {
      items.add(new Cafeteria.fromSnapShot(event.snapshot));
    });
  }

  void _onCaferiaUpdate(Event event) {
    var oldProductValue =
        items.singleWhere((product) => product.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldProductValue)] =
          new Cafeteria.fromSnapShot(event.snapshot);
    });
  }

  void _deleteCafeteria(
      BuildContext context, Cafeteria product, int position) async {
    await tbl.child(product.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToProductInformation(
      BuildContext context, Cafeteria product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductosCafetereria(product)),
    );
  }

  void _navigateToProduct(BuildContext context, Cafeteria cafeteria) async {
    await Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => CafeteriaInfo(product)),
      MaterialPageRoute(builder: (context) => CafeteriaInfo(cafeteria)),
    );
  }

  void _createNewProduct(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CafeteriaInfo(Cafeteria(null, '', '', ''))),
    );
  }

  


/*
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
*/
}