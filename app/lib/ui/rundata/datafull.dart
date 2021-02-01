import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'datarunner.dart';

class DataFull extends StatefulWidget {
  @override
  _DataFullState createState() => _DataFullState();
}

class _DataFullState extends State<DataFull> {
  SystemInstance _systemInstance = SystemInstance();
  List<DataRunner> _dataFull = [];

  Future _getDataFull() async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/data_user/test_load?type=Full',headers: header );
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

      _dataFull.add(dataRunner);
    }
    print("Run: ${_dataFull}");
    return _dataFull;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getDataFull(),
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
