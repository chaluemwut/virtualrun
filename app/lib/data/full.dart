import 'package:app/system/SystemInstance.dart';
import 'package:app/tester/testall.dart';
import 'package:flutter/material.dart';
import 'funrun.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/config.dart';
import 'dart:convert';
import 'regis/registerrun.dart';


class FullMarathon extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FullMarathon();
  }

}
class _FullMarathon extends State{
  SystemInstance _systemInstance = SystemInstance();
  List<Runner> runs = [];

  Future _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/show?type=Full',headers: header );
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
      runs.add(run);
    }
    print(runs);
    return runs;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Marathon'),),
      body: Container(
        child: FutureBuilder(
            future: _getData(),
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