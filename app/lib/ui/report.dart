import 'package:app/database.dart';
import 'package:flutter/material.dart';
import '../database.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/system/SystemInstance.dart';
import 'package:app/util/file_util.dart';
import 'package:app/config/config.dart';


class Report extends StatefulWidget {
  static const routeName = '/report';


  @override
  State<StatefulWidget> createState() {
    return _ReportState();
  }
}

class _ReportState extends State<Report> {
  List _uilist = List();
  FileUtil _fileUtil = FileUtil();
  SystemInstance _systemInstance = SystemInstance();
  var aid;
  var userId;
  @override
  void initState() {
    // _fileUtil.readFile().then((id){
    //   this.userId = id;
    //   print('id funrun ${userId}');
    // });
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/all_run/test=?Fun Run',headers: header ).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      Map resData = resMap['data'];
         for (int j = 0; j < resData.length; j++) {
            Map data = resData[j];
            Card card = Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {

                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('${data["distance"] + ' ' + 'กิโลเมตร'}'
                          '${'ภายใน' + ' ' + data['time'] + ' ' + 'วัน'}',),
                    ],
                  ),
                  // child: Text('${data["distance"]+' '+'กิโลเมตร'}'
                  //             '${'ภายใน'+' '+data['time']+' '+'วัน'}',
                  //   textAlign: TextAlign.center,),
                ),
              ),
            );

            _uilist.add(card);
            setState(() {});
          }
        }
    );
    super.initState();
  }


  Widget getItem(BuildContext context, int i) {
    return _uilist[i];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายการวิ่ง'),),
      body: ListView.builder (
        itemBuilder: getItem ,
        itemCount: _uilist.length ,
      ) ,

    );
  }
}