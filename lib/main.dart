import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mapa_app/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_mapa_app/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_mapa_app/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_mapa_app/src/pages/acceso_gps_page.dart';
import 'package:flutter_mapa_app/src/pages/loading-page.dart';
import 'package:flutter_mapa_app/src/pages/mapas_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MiUbicacionBloc(),
        ),
        BlocProvider(
          create: (context) => MapaBloc(),
        ),
        BlocProvider(
          create: (context) => BusquedaBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        home: LoadingPage(),
        //home: AccesoGpsPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso_gps': (_) => AccesoGpsPage(),
        },
      ),
    );
  }
}
