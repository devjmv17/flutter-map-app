import 'package:flutter/material.dart';
import 'package:flutter_mapa_app/src/pages/acceso_gps_page.dart';
import 'package:flutter_mapa_app/src/pages/loading-page.dart';
import 'package:flutter_mapa_app/src/pages/mapas_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoadingPage(),
      //home: AccesoGpsPage(),
      routes: {
        'mapa': (_) => MapaPage(),
        'loading': (_) => LoadingPage(),
        'acceso_gps': (_) => AccesoGpsPage(),
      },
    );
  }
}
