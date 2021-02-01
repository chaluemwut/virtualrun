import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:app/config/config.dart';
import 'package:app/nav/launcher.dart';
import 'package:app/run/showdata.dart';
import 'package:app/run/startrun.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/rundata/datarunner.dart';
import 'package:app/ui/running.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;

class Pause extends StatefulWidget {
  final String kmData;
  final String timeData;
  final String myType;

  const Pause({Key key, this.kmData, this.timeData,this.myType}) : super(key: key);
  @override
  _PauseState createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  Completer<GoogleMapController> _controller = Completer();
  var theKm = "0";
  var theTime;
  var hh;
  var mm;
  var ss;
  var theLat = 16.4464643;
  var theLng = 0.00;
  var sum = 0;
  var consum;
  var sumk = 0.0;

  var totalTime;
  var douTime;
  var cals ;
  int calories = 0;
  SystemInstance _systemInstance = SystemInstance();

  List _listSum = List();

  Map map = {};
  var distanceMessage = "";
  FileUtil _fileUtil = FileUtil();
  var userId;
  var theType;
  List<DataRunner> _listData = [];
  List aaa = List();
  List bbb = List();

  DateTime _dateTime = new DateTime.now();
  var date;


  @override
  void initState(){
    print(theKm);

    _fileUtil.readFile().then((value){
      this.userId = value;
      print("UserID:${userId}");
    });
    //cals = 68.83*3.02*1.306;
    // print(theKm);
    super.initState();
    calculate();
  }
  void calculateCals(){
    // print(theKm.runtimeType);
    var km = double.parse(theKm);
    // //var times = double.parse(theTime);
    // print(km);
    // print(km.runtimeType);
    cals = 68.83*km*1.036;
    calories = cals.toInt();
    // print(calories.runtimeType);
    // print(calories);
    // hh = theTime.substring(0,2);
    // mm = theTime.substring(3,5);
    // ss = theTime.substring(6,8);
    // print('HH:${hh}');
    // print('MM:${mm}');
    // print('ss:${ss}');
    // totalTime = "${mm}.${ss}";
    // print(totalTime);
    // douTime = double.parse(totalTime);
    // print(douTime);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    var total = 12742 * asin(sqrt(a));
    return total;
  }

  void calculate() {
    Map params = Map();
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/save_runner/load', headers: header,body: params).then((res) {
      //print("xxx");
      Map resMap = jsonDecode(res.body) as Map;
      //print('resMap:  ${resMap}');
      var data = resMap['data'];
      //print('data:   ${data}');
      for (var i in data) {
        //print('i: ${i}');
        var lat = i['lat'];
        var lng = i['lng'];
        map = {'lat': lat, 'lng': lng};
        // print("Map:${map}");
        _listSum.add(map);
        // resLat = i['lat'].toStringAsFixed(7);
        // resLng = i['lng'].toStringAsFixed(7);
      }
      //print(_listSum);
      // print(_listSum.runtimeType);
      double totalDistance = 0;
      for (var i = 0; i < _listSum.length - 1; i++) {
        totalDistance +=
            calculateDistance(_listSum[i]["lat"], _listSum[i]["lng"],
                _listSum[i + 1]["lat"], _listSum[i + 1]["lng"]);
      }
      distanceMessage = totalDistance.toStringAsFixed(2);
      // paceDis = double.parse(distanceMessage);
      // print("fsdf${paceDis}");
      setState(() {

        //print('${distanceMessage}Km');
      });
      return distanceMessage;
    });

  }

  void loadToPolyline(){
    Map params = Map();
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/save_runner/load', headers: header,body: params).then((res) {
      print("xxx");
      Map resMap = jsonDecode(res.body) as Map;
      print('resMap:  ${resMap}');
      var data = resMap['data'];
      print('data:   ${data}');
      for (var i in data) {
        print('i: ${i}');
        var lat = i['lat'];
        var lng = i['lng'];
        print("lat${lat}");
        print("lat${lng}");
      }
      setState(() {
      });
    });
  }
  List<double> _list = [];
  var point = <LatLng>[
    LatLng(16.4464643,102.8492125),
    LatLng(16.4467942,102.8494465),
    LatLng(16.4472939,102.8496678),
    LatLng(16.4475511,102.8497208),
    LatLng(16.4479724,102.8497248),
    LatLng(16.4484631,102.8496376),
    LatLng(16.4489853,102.8494184),
    LatLng(16.4493364,102.8494921),
    LatLng(16.4511137,102.848984),
    LatLng(16.4516719,102.8491409),
    LatLng(16.4518861,102.8496344),
    LatLng(16.4519758,102.8535971),
    LatLng(16.4514739,102.8547799),
    LatLng(16.4509434,102.8551825),
    LatLng(16.4501508,102.8550715),
    LatLng(16.4497263,102.8544097),
    LatLng(16.4452104,102.8520371),
    LatLng(16.4464643,102.8492125),
  ];

  void saveToData(){
    Map params = Map();
    params['userId'] = userId.toString();
    params['km'] = distanceMessage.toString();
    params['time'] = theTime.toString();
    params['type'] = theType.toString();
    params['dateNow'] = date.toString();
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/test_data/save',headers: header,body: params).then((res){
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    date = ("${_dateTime.day}/${_dateTime.month}/${_dateTime.year}");
    theKm = widget.kmData;
    theTime = widget.timeData;
    theType = widget.myType;
    print("tpe:${theType}");
    calculateCals();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('พัก'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 300,
                child: GoogleMap(
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(16.4329112, 102.823361),
                    zoom: 16,
                  ),

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  polylines: {
                    Polyline(
                        polylineId: PolylineId("p1"),
                        color: Colors.blue,
                        points: point
                    )
                  },
                ),

              ),

              Container(
               child: Padding(
                 padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                 child: Column(
                   children: [
                     Row(
                       children: <Widget>[
                         Expanded(
                           child: Text('${distanceMessage}', textAlign: TextAlign.center,style: TextStyle(fontSize: 35),),

                         ),
                         Expanded(
                           child: Text('${calories}', textAlign: TextAlign.center,style: TextStyle(fontSize: 35),),

                         ),
                         Expanded(
                           child: Text('${theTime}',textAlign: TextAlign.center,style: TextStyle(fontSize: 32),),
                         ),
                       ],
                     ),
                     Row(
                       children: <Widget>[
                         Expanded(
                           child: Text('กิโลเมตร', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),

                         ),
                         Expanded(
                                 child: Text('แคลอรี่', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),

                               ),
                         Expanded(
                           child: Text('เวลา',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                         ),
                       ],
                     ),
                     Padding(
                       padding: EdgeInsets.only(top: 20),
                     ),
                     // Row(
                     //   children: <Widget>[
                     //
                     //     Expanded(
                     //       child: Text('0 ม.', textAlign: TextAlign.center,style: TextStyle(fontSize: 40),),
                     //     ),
                     //     Expanded(
                     //       child: Text('--',textAlign: TextAlign.center,style: TextStyle(fontSize: 40),),
                     //     ),
                     //   ],
                     // ),
                     // Row(
                     //   children: <Widget>[
                     //     Expanded(
                     //       child: Text('แคลอรี่', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                     //
                     //     ),
                     //     Expanded(
                     //       child: Text('วิ่งไต่ระดับ', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                     //     ),
                     //     Expanded(
                     //       child: Text('ครั้งต่อนาที',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                     //     ),
                     //   ],
                     // ),
                     Divider(
                       height: 20,
                       thickness: 5,
                       indent: 20,
                       endIndent: 20,
                       color: Colors.grey[800],
                     ),
                     Padding(
                       padding: EdgeInsets.only(top: 20),
                     ),
                     Row(
                       children: [
                         Expanded(
                           child: Container(
                             child: Ink(
                               decoration: const ShapeDecoration(
                                 color: Colors.lightBlue,
                                 shape: CircleBorder(),
                               ),
                               child: IconButton(
                                 icon: Icon(Icons.stop),
                                 color: Colors.white,
                                 iconSize: 100,
                                 onPressed: () {
                                   //saveToData();
                                     Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(builder: (context) => ShowDataScreen(myType: theType,myCal: calories,)));
                                   // Navigator.pop(context);
                                   // Navigator.pop(context);
                                   // Navigator.pop(context);
                                 },
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}

