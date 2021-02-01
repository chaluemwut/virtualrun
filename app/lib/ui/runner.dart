import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/running.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Runner extends StatefulWidget {
  @override
  _RunnerState createState() => _RunnerState();
}

class _RunnerState extends State<Runner> {
  SystemInstance _systemInstance = SystemInstance();
  final _date = new DateTime.now();

  List<DataRun> dataRuns = List();
  final List<String> _list = List<String>.generate(20, (index) => "Item: ${++index}");
  List _lst = List();
  var id;
  var isType;
  var dateS;
  var dateE;

  // Future _getDataIn() {
  //
  //   Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
  //   http.post('${Config.API_URL}/user_run/test_show?userId=8',headers: header).then((res) {
  //     Map resMap = jsonDecode(res.body) as Map;
  //     print(resMap);
  //     var _data = resMap["data"];
  //     print("_data: ${_data}");
  //     //_listData = _data;
  //     for(var i in _data){
  //       DataRun run = DataRun(
  //           i["aid"],
  //           i["distance"],
  //           i["time"],
  //           i["type"]
  //       );
  //       dataRuns.add(run);
  //     }
  //     print("Run: ${dataRuns}");
  //     return dataRuns;
  //   });
  //
  // }
  @override
  void initState(){

    super.initState();
  }

  Future<List<DataRun>> _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_run/test_show?userId=${id}',headers: header );
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    // print(_data);
    // print(sum);
    for(var i in sum){
      // print(i);
      DataRun run = DataRun(
          i["id"],
          i["distance"],
          i["type"],
          i["dateStart"],
          i["dateEnd"],
      );
      // print("sada: ${run}");
      dataRuns.add(run);
    }
    // print("Run: ${dataRuns}");
    return Future.value(dataRuns);
    // return dataRuns;
  }
  Future showCustomDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text('ไม่ตรงตามเงื่่อนไขที่กำหนด'),
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
    SystemInstance systemInstance = SystemInstance();
    id = systemInstance.userId;
    // print("ID${id}");
    //show();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายการที่ลงทะเบียนไว้'),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child:
                FutureBuilder(
                    future: _getData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                         if(snapshot.data == null){
                           return Padding(padding: EdgeInsets.all(0),);
                         } else {
                           return ListView.builder(
                               shrinkWrap: true,
                               // itemBuilder: getItem ,
                               itemCount: snapshot.data.length,
                               itemBuilder: (BuildContext context, int index) {
                                 return Card(
                                   shape: RoundedRectangleBorder(
                                       borderRadius:
                                       BorderRadius.all(Radius.circular(8.0))),
                                   child: ListTile(
                                     leading: Icon(Icons.add_circle),
                                     title: Text('ระยะทาง ' + snapshot.data[index].distance +' กิโลเมตร'),
                                     subtitle: Text(' จากวันที่ ' + snapshot.data[index].dateStart + ' ถึงวันที่ '
                                         + snapshot.data[index].dateEnd),
                                     onTap: () {
                                       int aaId = id;
                                       print(aaId);
                                       isType = snapshot.data[index].type;
                                       dateS = snapshot.data[index].dateStart;
                                       dateE = snapshot.data[index].dateEnd;
                                       var conS = new DateFormat('dd/mm/yyyy').parse(dateS);
                                       var conE = new DateFormat('dd/mm/yyyy').parse(dateE);
                                       var conN = new DateTime.now();
                                       var date2s = ('${_date.day}/${_date.month}/${_date.year}');
                                       var s2date = new DateFormat('dd/mm/yyyy').parse(date2s);
                                       var dateN2s = ('${conN.day}/${conN.month}/${conN.year}');
                                       var s2dateN = new DateFormat('dd/mm/yyyy').parse(dateN2s);
                                       var ds = ('29/01/2021');
                                       var de = ('31/01/2021');
                                       var ds2d = new DateFormat('dd/mm/yyyy').parse(ds);
                                       var de2d = new DateFormat('dd/mm/yyyy').parse(de);
                                       print(ds2d);
                                       if((s2date==ds2d || s2date.isAfter(ds2d)) && (s2date==de2d || s2date.isBefore(de2d))){
                                         print('0');
                                         Navigator.push(
                                             context,
                                             MaterialPageRoute(
                                                 builder: (BuildContext context) =>
                                                     Running(idrunner: aaId,isType:isType)));
                                       }else{
                                         print('1');
                                         showCustomDialog(context);
                                       }
                                     },
                                   ),
                                 );
                               });
                         }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataRun {
  final int id;
  final String distance;
  final String type;
  final String dateStart;
  final String dateEnd;


  DataRun(this.id, this.distance, this.type, this.dateStart, this.dateEnd);

}

class TheRunnerData extends StatefulWidget {
  @override
  _TheRunnerDataState createState() => _TheRunnerDataState();
}

class _TheRunnerDataState extends State<TheRunnerData> {
  SystemInstance _systemInstance = SystemInstance();
  List<DataRun> reruns = List();
  var aa = 20;
  final List<dynamic> _list = List<String>.generate(20, (index) => "Item: ${++index}");
  List _lst = List();
  Map _map={};
  List _listData = List();

  @override
  void initState() {
    _getDataIn();
    super.initState();
  }

  void _getDataIn() {
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/user_run/test_show?userId=8',headers: header).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
      var _data = resMap["data"];
      print("_data: ${_data}");
      _listData = _data;
      for (var i in _data) {
        print("I:${i}");
        var aid = i["aid"];
        var distance = i["distance"];
        var time = i["time"];
        var type = i["type"];
        _map = {'aid': aid, 'distance': distance, 'time': time, 'type': type};
        _lst.add(_map);
      }
      print("fsfd${_listData}");
      print("List: ${_lst}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: _lst.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    child: InkWell(
                      onTap: () => {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Half())),
                      },
                      child: ListTile(
                        leading: Icon(Icons.access_alarm),
                        title: Text('ระยะทาง '' กิโลเมตร'+' ภายใน '' วัน'),
                        subtitle: Text("Cfds"),
                        trailing: Icon(Icons.map),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
