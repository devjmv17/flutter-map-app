import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mapa_app/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_mapa_app/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_mapa_app/src/widgets/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) => crearMapa(state)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
        ],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.exiteUbicacion) return Center(child: Text('Ubicando ...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));
    // return Center(
    //     child:
    //         Text('${state.ubicacion.latitude} , ${state.ubicacion.longitude}'));
    final CameraPosition _kGooglePlex = CameraPosition(
      //target: LatLng(37.42796133580664, -122.085749655962),
      target: state.ubicacion,
      zoom: 18,
    );
    final destino = state.ubicacion;
    mapaBloc.moverCamara(destino);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      compassEnabled: true,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,

      //onMapCreated: (GoogleMapController controller) =>
      //    mapaBloc.initMapa(controller),
      // Las dos lineas de arriba se pueden reducir a :
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        // camera Postition.target= LatLng central del mapa
        mapaBloc.add(OnMovioMapa(cameraPosition.target));
      },
      onCameraIdle: () {},
    );
  }
}
