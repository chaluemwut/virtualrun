import 'dart:convert';
import 'package:app/system/SystemInstance.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/config.dart';
import 'package:app/data/regis/registerrun.dart';
import 'package:app/data/add.dart';

class FunRun extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FunRun();
  }

}
class _FunRun extends State {

  List _uilist = List();
  FileUtil _fileUtil = FileUtil();
  SystemInstance _systemInstance = SystemInstance();
  var aid;
  var userId;
  List<Run> runs = [];

  Future _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/all_run/test?type=Fun Run',headers: header );
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


  @override
  void initState() {
    _fileUtil.readFile().then((id){
      this.userId = id;
      print('id funrun ${userId}');
    });
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/all_run/test?type=Fun Run',headers: header ).then((res) {
   // http.post('${Config.API_URL}/all_run/show_fun',headers: header ).then((res) {
      var data = http.post('${Config.API_URL}/all_run/test?type=Fun Run',headers: header );
      print('sfkfdkj ${data}');
      // Map resMap = jsonDecode(res.body) as Map;
      // print(resMap);
      //List resData = resMap["data"];
      // for (int i = 0; i < resData.length; i++) {
      //   _systemInstance.aid = aid;
      //   if (i == 0) {
      //       Map data = resData[i];
      //       Card card = Card(
      //         child: InkWell(
      //           splashColor: Colors.blue.withAlpha(30),
      //           onTap: () {
      //             if (i == 0) {
      //               Navigator.push(context, MaterialPageRoute(
      //                 builder: (context) => RegisterFunRun(aid: aid,),
      //               ),
      //               );
      //             } else if (i == 1) {
      //               int bb = resData[1]["aid"];
      //               Navigator.push(context,
      //                 MaterialPageRoute(
      //                   builder: (context) => RegisterFunRun(),),);
      //             } else if (i == 2) {
      //               Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) =>
      //                     RegisterFunRun(),),);
      //             }
      //           },
      //           child: Container(
      //             width: 300,
      //             height: 100,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Text('${data["distance"] + ' ' + 'กิโลเมตร'}'
      //                     '${'ภายใน' + ' ' + data['time'] + ' ' + 'วัน'}',),
      //               ],
      //             ),
      //             // child: Text('${data["distance"]+' '+'กิโลเมตร'}'
      //             //             '${'ภายใน'+' '+data['time']+' '+'วัน'}',
      //             //   textAlign: TextAlign.center,),
      //           ),
      //         ),
      //       );
      //
      //       _uilist.add(card);
      //       setState(() {});
      //     }
      //   }
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
        title: Text('Fun Run'),),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,MaterialPageRoute(builder: (context) => AddTournament()));
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),

    );
  }
}

class Run{
  final int aid;
  final String distance;
  final String time;
  final String type;

  Run(this.aid, this.distance, this.time, this.type);
}
