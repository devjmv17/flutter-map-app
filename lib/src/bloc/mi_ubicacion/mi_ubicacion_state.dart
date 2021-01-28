part of 'mi_ubicacion_bloc.dart';

@immutable
class MiUbicacionState {
  final bool siguiendo;
  final bool exiteUbicacion;
  final LatLng ubicacion;

  MiUbicacionState(
      {this.siguiendo = true, this.exiteUbicacion = false, this.ubicacion});

  MiUbicacionState copyWith(
          {bool siguiendo, bool exiteUbicacion, LatLng ubicacion}) =>
      new MiUbicacionState(
          siguiendo: siguiendo ?? this.siguiendo,
          exiteUbicacion: exiteUbicacion ?? this.exiteUbicacion,
          ubicacion: ubicacion ?? this.ubicacion);
}
