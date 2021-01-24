import 'package:flutter/material.dart';
import 'package:flutter_mapa_app/src/helpers/helpers.dart';
import 'package:flutter_mapa_app/src/pages/acceso_gps_page.dart';
import 'package:flutter_mapa_app/src/pages/mapas_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('==loadding==> $state');
    if (state == AppLifecycleState.resumed) {
      if (await GeolocatorPlatform.instance.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.checkGpsYlocation(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Text(snapshot.data),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
      },
    );
  }

  Future checkGpsYlocation(BuildContext context) async {
    final permisoGps = await Permission.location.isGranted;
    final gpsActivo =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();

    await Future.delayed(Duration(milliseconds: 100));

    if (permisoGps && gpsActivo) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, MapaPage()));
      return '';
    } else if (!permisoGps) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso del Gps para poder utilizar esta Aplicación';
      print(
          'Es necesario el permiso del Gps para poder utilizar esta Aplicación');
      return '';
    } else if (!gpsActivo) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, AccesoGpsPage()));
      //return ' Active el Gps para poder utilizar esta Aplicación';
      print(' Active el Gps para poder utilizar esta Aplicación');
      return '';
    }
    // Navigator.pushReplacement(
    //     context, navegarMapaFadeIn(context, AccesoGpsPage()));
    //Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
  }
}
