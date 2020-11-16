import 'dart:math';
import 'file:///E:/virtualrun/app/lib/config/config.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class Running extends StatefulWidget {
  static const routeName = '/running';

  @override
  State<StatefulWidget> createState() {
    return _RunningState();
  }
}

class _RunningState extends State<Running> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('วิ่ง'),
      ),

      body: Padding(
        padding: EdgeInsets.all(10),
          child: ListView(
             children: <Widget>[
               SizedBox(
                 height: 450,
                 width: 300,
                 child: GoogleMap(
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

               ),

               Container(
                   height: 50,
                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                   child: RaisedButton(
                     textColor: Colors.white,
                     color: Colors.blue,
                     child: Text('เริ่มวิ่ง'),
                     onPressed: () {
                       //Navigator.push(context,
                       //  MaterialPageRoute(builder: (context) => MapSample()));
                     },
                   ),

               ),
             ],
           ),

        ),
      /*floatingActionButton: FloatingActionButton.extended(
          onPressed: _goTome,
          label: Text('My location'),
          icon: Icon(Icons.gps_fixed)
      ),*/
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

