import 'dart:convert';
import 'package:app/system/SystemInstance.dart';
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
        title: Text('Mini Marathon'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            return ListView.builder (
              // itemBuilder: getItem ,
                itemCount: snapshot.data.length ,
                itemBuilder: (BuildContext context,int index){
                  return Card(
                    child: ListTile(
                      title: Text('ระยะทาง '+snapshot.data[index].distance+' กิโลเมตร'+' ภายใน '+snapshot.data[index].time+' วัน'),
                      onTap: (){
                        int aId = snapshot.data[index].aid;
                        print(aId);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) => RegisterRun(aaid: aId,)));
                      },
                    ),
                  );
                }

            );
          }
        ),
      ),
    );
  }

}
