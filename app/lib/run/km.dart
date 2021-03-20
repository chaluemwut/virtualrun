import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/rundata/datarunner.dart';
import 'package:app/ui/running.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class KilometerScreen extends StatefulWidget {
  final int id;
  final String type;
  final String km;

  const KilometerScreen({Key key, this.id,this.type,this.km}) : super(key: key);
  @override
  _KilometerScreenState createState() => _KilometerScreenState();
}

class _KilometerScreenState extends State<KilometerScreen> {
  SystemInstance _systemInstance = SystemInstance();
  var userId;
  var theType;
  var aid;
  var distance;
  var theKm;
  List aaa = List();
  List km = List();
  List time = List();
  List<DataRunner> _list = List();
  List<DataRunner> _listData = [];
  var sum = 0;
  var consum = "00:00:00";
  var sumk = 0.0;

  void initState(){
    SystemInstance systemInstance = SystemInstance();
    userId = systemInstance.userId;
    theType = widget.type;
    aid = widget.id;
    _getData();
    _getNewData();
    super.initState();
  }

  Future _getNewData() async {
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/total_data/show?userId=${userId}&id=${aid}',headers: header);
    var _data = jsonDecode(data.body);
    print(_data);
    for (var i in _data) {
      print(i);
      DataRunner dataRunner = DataRunner(
        i["did"],
        i["userId"],
        i["id"],
        i["km"],
        i["time"],
        i["type"],
        i["dateNow"],

      );
      time.add(i["time"]);
      km.add(i["km"]);
      _listData.add(dataRunner);
    }
    print("Run: ${_listData}");
    print(time);
    print(km);
    for (var i in km) {
      print(i);
      var k = double.parse(i);
      sumk = sumk + k;
    }
    print(sumk);
    print(sum.runtimeType);
    print(sumk.runtimeType);
    setState(() {
      sum = sum;
      sumk = sumk;
    });
    return _listData;
    // return Future.value(_listData);
  }

  Future _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_data/show?userId=${userId}&id=${aid}',headers: header );
    var _data = jsonDecode(data.body);
    print("Data:${_data}");
    for (var i in _data){
      print("I:${i}");
      DataRunner dataRunner = DataRunner(
        i["did"],
        i["userId"],
        i["id"],
        i["km"],
        i["time"],
        i["type"],
        i["dateNow"],
      );
      aaa.add(i["km"]);
      _list.add(dataRunner);
      print("flfl${_list}");
    }
    print(_list);
    return _list;
  }

  Future showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('ไม่ตรงตามเงื่อนไขที่กำหนด'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ปิด'),
          )
        ],
      )
  );


  @override
  Widget build(BuildContext context) {
    distance = widget.km;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('km'),
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
      body: _listData.isEmpty ? Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: ListTile(
          leading: Icon(Icons.directions_run),
          title: Text('ระยะทาง $distance กิโลเมตร'),
          subtitle: Text('ระยะทางที่วิ่งได้ 0 กิโลเมตร'),
          onTap: (){
            print("empty");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Running(isType:theType,idrunner: aid,)));
          },
        ),
      ) : ListView.builder(
          shrinkWrap: true,
          // itemBuilder: getItem ,
          itemCount: _listData.length,
          itemBuilder: (BuildContext context, int index) {
            var item = _listData[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: ListTile(
                leading: Icon(Icons.directions_run),
                title: Text('ระยะทาง $distance กิโลเมตร'),
                subtitle: Text(' ระยะทางที่วิ่งได้  ${sumk} กิโลเมตร'),
                onTap: () {
                  int aaId = item.id;
                  print("allRunId = $aaId");
                  theKm = item.km;
                  // var theDis = 10;
                  var theDis = double.parse(distance);
                  var myKm = double.parse(theKm);
                  // myKm = 5;
                  if(myKm < theDis){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Running(idrunner: aaId,isType:theType)));
                  }else{
                    showCustomDialog(context);
                  }
                },
              ),
            );
          }),
    );
  }
}
