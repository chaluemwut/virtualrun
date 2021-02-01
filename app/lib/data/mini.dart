import 'dart:convert';
import 'package:app/system/SystemInstance.dart';
import 'package:app/tester/testall.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import 'funrun.dart';
import 'package:app/data/regis/registerrun.dart';

class Mini extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Mini();
  }

}
class _Mini extends State{
  SystemInstance _systemInstance = SystemInstance();
  List<Run> runs = [];
  List<Runner> _list = [];


  Future _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/all_run/test?type=Mini',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    for(var i in _data){
      Run run = Run(
          i["aid"],
          i["distance"],
          i["time"],
          i["type"]
      );
      runs.add(run);
    }
    print(runs);
    return runs;
  }

  Future _getTheData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/show?type=Mini',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    for(var i in _data){
      Runner run = Runner(
        i["id"],
        i["distance"],
        i["type"],
        i["dateStart"],
        i["dateEnd"],
      );
      _list.add(run);
    }
    print(_list);
    return _list;
  }

  // @override
  // void initstate(){
  //   Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
  //   var data = http.post('${Config.API_URL}/all_run/test?type=Mini',headers: header );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mini Marathon'),
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
        child: FutureBuilder(
          future: _getTheData(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Padding(padding: EdgeInsets.all(0),);
            } else {
              return ListView.builder(
                // itemBuilder: getItem ,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.add_circle),
                        title: Text('ระยะทาง ' + snapshot.data[index].distance +' กิโลเมตร'),
                        subtitle: Text(' จากวันที่ ' + snapshot.data[index].dateStart + ' ถึงวันที่ '
                            + snapshot.data[index].dateEnd),
                        onTap: () {
                          int aId = snapshot.data[index].id;
                          print(aId);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RegisterRun(aaid: aId,)));
                        },
                      ),
                    );
                  }

              );
            }
          }
        ),
      ),
    );
  }

}
