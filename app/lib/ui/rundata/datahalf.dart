import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/ranking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'datarunner.dart';
class DataHalf extends StatefulWidget {
  @override
  _DataHalfState createState() => _DataHalfState();
}

class _DataHalfState extends State<DataHalf> {
  SystemInstance _systemInstance = SystemInstance();
  List<DataRunner> _dataHalf = [];

  Future _getDataHalf() async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/data_user/test_load?type=Half',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    for(var i in _data){
      print(i);
      DataRunner dataRunner = DataRunner(
        i["did"],
        i["userId"],
        i["km"],
        i["time"],
        i["type"],
      );

      _dataHalf.add(dataRunner);
    }
    print("Run: ${_dataHalf}");
    return _dataHalf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getDataHalf(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Padding(
                padding: EdgeInsets.all(0),
              );
            } else {
              return ListView.builder(
                // itemBuilder: getItem ,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Card(
                          child: InkWell(
                            child: ListTile(
                              title: Text('ระยะทาง ' +
                                  snapshot.data[index].km +
                                  ' กิโลเมตร' +
                                  ' ภายใน ' +
                                  snapshot.data[index].time +
                                  ' วัน'),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
