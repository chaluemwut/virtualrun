import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

class Polyline extends StatefulWidget {
  @override
  _PolylineState createState() => _PolylineState();
}

class _PolylineState extends State<Polyline> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Maps'),),
      body: new FlutterMap(
        options: new MapOptions(
        ),
      ),
    );
  }


}
