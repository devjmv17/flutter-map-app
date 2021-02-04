import 'package:dio/dio.dart';
import 'package:flutter_mapa_app/src/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }
  final _dio = new Dio();
  final baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey =
      'pk.eyJ1IjoiZGV2am12MTciLCJhIjoiY2trbDBneWltMDlkdzJwcnFwNHpuamI3dyJ9.wRs91cw7hoFBzNGg0imA_A';

// https://api.mapbox.com/directions/v5
// /mapbox/driving/-1.0837205618236965%2C38.047091828499674%3B-1.0844067168109461%2C38.03286407501284?alternatives=true&geometries=polyline6&steps=false&access_token=pk.eyJ1IjoiZGV2am12MTciLCJhIjoiY2trbDBneWltMDlkdzJwcnFwNHpuamI3dyJ9.wRs91cw7hoFBzNGg0imA_A&language=es

  Future getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {
    print('Inicio: $inicio');
    print('Destino: $destino');
    final coordString =
        '${inicio.longitude},${inicio.latitude}; ${destino.longitude},${destino.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordString';
    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es'
    });
    //print(resp);
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }
}
