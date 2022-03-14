import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lista_veiculos/model/list_positions.dart';
import 'package:lista_veiculos/model/position.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

 @override
  _OurMapaState createState() => _OurMapaState();
  }


class _OurMapaState extends State<Mapa> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  Position? position;
  ListPositions? listPositions;
  late CameraPosition _position;
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (ModalRoute
        .of(context)!
        .settings
        .arguments is Position) {
      position = ModalRoute
          .of(context)!
          .settings
          .arguments as Position?;
    } else {
      listPositions = ModalRoute
          .of(context)!
          .settings
          .arguments as ListPositions?;
    }

    if (position != null) {
      _position = CameraPosition(
        target: LatLng(position!.lat, position!.lng),
        zoom: 14.4746,
      );
    } else {
      _position = CameraPosition(
        target: LatLng(
            listPositions!.positions[0].lat, listPositions!.positions[0].lng),
        zoom: 18.4746,
      );
    }

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _position,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  Future<void> _onMapCreated (GoogleMapController controller) async {
    if (position != null) {
      final marker = Marker(
        markerId: MarkerId(position!.veiculo_placa),
        position: LatLng(position!.lat, position!.lng),
      );
      markers[marker.markerId] = marker ;
    } else {
      List<LatLng> latLngs = [] ;
      for (final position in listPositions !.positions) {
        LatLng latLng = LatLng(position. lat, position.lng);
        latLngs.add(latLng) ;
        final marker = Marker(
          markerId: MarkerId(position. veiculo_placa ),
          position: latLng ,
          infoWindow: InfoWindow (
            title: position. veiculo_placa ,
            snippet: position. condutor_nome ,
          ),
        );
        markers[marker.markerId] = marker ;
      }
//como deixar todos markers visíveis

      LatLngBounds bounds = boundsFromLatLngList(latLngs);
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 45.0),
      );
    }
    setState(() {}) ;
  }



LatLngBounds boundsFromLatLngList(List<LatLng> list) {
  double? x0, x1, y0, y1;
  for (LatLng latLng in list) {
    if (x0 == null) {
      x0 = x1 = latLng.latitude;
      y0 = y1 = latLng.longitude;
    } else {
      if (latLng.latitude > x1!) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1!) y1 = latLng.longitude;
      if (latLng.longitude < y0!) y0 = latLng.longitude;
    }
  }
  return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
}
}