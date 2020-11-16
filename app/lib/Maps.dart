import 'dart:math';
import 'file:///E:/virtualrun/app/lib/config/config.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MyMapPageState();
}

class MyMapPageState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map'),),
      body: GoogleMap(
        myLocationEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(16.4329112, 102.823361),
          zoom: 12,
        ),

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _goTome,
          label: Text('My location'),
          icon: Icon(Icons.gps_fixed)
      ),

    );
  }


  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {

      }
      return null;
    }
  }


  Future _goTome() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
            currentLocation.latitude,
            currentLocation.longitude),
        zoom: 18,
      ),
    ),
    );
  }


  static double getDistanceFromGPSPointsInRoute(List<LatLng> gpsList) {
    double totalDistance = 0.0;

    for (var i = 0; i < gpsList.length; i++) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((gpsList[i + 1].latitude - gpsList[i].latitude) * p) / 2 +
          c(gpsList[i].latitude * p) *
              c(gpsList[i + 1].latitude * p) *
              (1 - c((gpsList[i + 1].longitude - gpsList[i].longitude) * p)) /
              2;
      double distance = 12742 * asin(sqrt(a));
      totalDistance += distance;
      print('Distance is ${12742 * asin(sqrt(a))}');
    }
    print('Total distance is $totalDistance');
    print('');

    return totalDistance;
  }
}

/*
class Distance extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Distance();
  }


}
class _Distance extends State{
  final Distance distance = new Distance();

  // km = 423
  final int km = distance.as(LengthUnit.Kilometer,
      new LatLng(52.518611,13.408056),new LatLng(51.519475,7.46694444));

  // meter = 422591.551
  final int meter = distance(
      new LatLng(52.518611,13.408056),
      new LatLng(51.519475,7.46694444)
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null();
  }

}*/