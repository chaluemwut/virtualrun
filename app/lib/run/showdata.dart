import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/rundata/datarunner.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowDataScreen extends StatefulWidget {
  final String myType;
  final int myCal;

  const ShowDataScreen({Key key, this.myType,this.myCal}) : super(key: key);

  @override
  _ShowDataScreenState createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  FileUtil _fileUtil = FileUtil();
  var userId;
  SystemInstance _systemInstance = SystemInstance();
  List<DataRunnerNow> runs = List();
  List<DataRunner> _listData = [];
  List aaa = List();
  List bbb = List();
  var theType = '';
  var sum = 0;
  var consum = "00:00:00";
  var sumk = 0.0;
  var id;
  var cal;

  @override
  void initState() {
    // onclick();
    // _getData();
    // _fileUtil.readFile().then((value) {
    //   this.userId = value;
    //   print("UserID:${userId}");
    // });
    SystemInstance systemInstance = SystemInstance();
    id = systemInstance.userId;
    userId = id;
    theType = widget.myType;
    print(theType);
    print(userId);


    _getData();
    super.initState();
    // showData();
  }

  Future _getDataNew() async {
    Map<String, String> header = {
      "Authorization": "Bearer ${_systemInstance.token}"
    };
    var data = await http.post('${Config.API_URL}/test_all/show?type=Mini',
        headers: header);
    var _data = jsonDecode(data.body);
    print(_data);
    for (var i in _data) {
      DataRunnerNow run = DataRunnerNow(
        i["id"],
        i["userId"],
        i["km"],
        i["type"],
        i["dateNow"],
      );
      runs.add(run);
    }
    print(runs);
    return runs;
  }

  Future _getData() async {
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/data_user/get_data?userId=${userId}&type=${theType}',headers: header);
    var _data = jsonDecode(data.body);
    print(_data);
    for (var i in _data) {
      print(i);
      DataRunner dataRunner = DataRunner(
        i["did"],
        i["userId"],
        i["km"],
        i["time"],
        i["type"],
      );
      aaa.add(i["time"]);
      bbb.add(i["km"]);
      _listData.add(dataRunner);
    }
    print("Run: ${_listData}");
    print(aaa);
    print(bbb);
    for (var i in aaa) {
      print(i);
      var hh = i.substring(0, 2);
      var mm = i.substring(3, 5);
      var ss = i.substring(6, 8);

      var h = int.parse(hh);
      var m = int.parse(mm);
      var s = int.parse(ss);

      var htos = h * 60 * 60;
      var mtos = m * 60;
      var total = htos + mtos + s;

      sum = sum + total;
    }
    print("รวม:${sum}");
    var sstom = sum / 60;
    print("วิไปนาที:${sstom}");

    var ssstom = "0${sstom}";
    print("วิไปนาทีแถม0:${ssstom}");

    var mmm = ssstom.toString().substring(0, 2);
    var sss = ssstom.toString().substring(3, 5);
    print("เฉพาะนาที:${mmm}");
    var ssss = "0.${sss}";
    print("เฉพาวินาที:${ssss}");

    var stoi = double.parse(ssss);
    print("วิเป็น double:${stoi}");

    var stos = stoi * 60;
    var datas = stos.toStringAsFixed(0);
    print("s to s:${datas}");

    consum = "00:${mmm}:${datas}";
    print("แปลงกลับ => ${consum}");

    for (var i in bbb) {
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

  void showData(){
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/data_user/get_data?userId=${userId}&type=${theType}',headers: header).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
      var _data = resMap['data'];
      // for(var i in _data){
      //   print(i);
      //   var km = i['km'];
      //   var time = i['time'];
      //   print(km);
      // }
    });
  }
  void onclick(){
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    SystemInstance systemInstance = SystemInstance();
    theType = widget.myType;
    id = systemInstance.userId;
    userId = id;
    cal = widget.myCal;
    // print("showID:${userId}");
    // print("showType:${theType}");
    //_getData();
    //showData();
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลรวมของผู้ใช้'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('${sumk}',textAlign: TextAlign.center,style: TextStyle(fontSize: 35),
                    ),
                  ),
                  Expanded(
                    child: Text('${cal}',textAlign: TextAlign.center,style: TextStyle(fontSize: 35),
                    ),
                  ),
                  Expanded(
                    child: Text('${consum}',textAlign: TextAlign.center,style: TextStyle(fontSize: 32),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('กิโลเมตร',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: Text('แคลอรี่',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Expanded(
                    child: Text('เวลา',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class DataRunnerNow {
  final int id;
  final int userId;
  final String km;
  final String type;
  final String dateNow;

  DataRunnerNow(this.id, this.userId, this.km, this.type, this.dateNow);
}
