import 'dart:convert';
import 'package:app/system/SystemInstance.dart';
import 'package:app/tester/testall.dart';
import 'package:app/ui/profile.dart';
import 'package:app/util/file_util.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
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
  List<Run> _list = [];
  var userId;
  var aaid;
  FileUtil _fileUtil = FileUtil();
  var stat = "";

  // Future _getData()async{
  //   Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
  //   var data = await http.post('${Config.API_URL}/all_run/test?type=Mini',headers: header );
  //   var _data = jsonDecode(data.body);
  //   print(_data);
  //   for(var i in _data){
  //     Run run = Run(
  //         i["aid"],
  //         i["distance"],
  //         i["time"],
  //         i["type"]
  //     );
  //     runs.add(run);
  //   }
  //   print(runs);
  //   return runs;
  // }

  Future _getTheData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/show?type=Mini',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    for(var i in _data){
      Run run = Run(
        i["id"],
        i["nameAll"],
        i["distance"],
        i["type"],
        i["dateStart"],
        i["dateEnd"],
        i["imgAll"],
      );
      _list.add(run);
    }
    print(_list);
    return _list;
  }
  Future showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('สมัครสำเร็จ'),
        actions: [
          FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            child: Text('ปิด'),
          )
        ],
      )
  );
  Future showCustomDialogFailed(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('ท่านได้สมัครรายการนี้ไปแล้ว'),
        actions: [
          FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            child: Text('ปิด'),
          )
        ],
      )
  );
  Future showCustomDialogNot(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('สำหรับระบบเท่านั้น'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ปิด'),
          )
        ],
      )
  );
  Future showCustomDialogDelete(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('ต้องการรายการลบหรือไม่'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),

            child: Text('ไม่',style: TextStyle(color: Colors.red),),
          ),
          FlatButton(
            onPressed: () => {
              removeList(),
              Navigator.of(context).pop(),
            },
            child: Text("ใช่",style: TextStyle(color: Colors.blue),),
          ),
        ],
      )
  );
  void saveData(){
    print(aaid);
    Map params = Map();
    params['id'] = aaid.toString();
    params['userId'] = userId.toString();
    print(params);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/test_run/save_run',headers: header, body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print("resMap$resMap");
      var data = resMap['status'];
      print(data);
      if(data == 1){
        print("yes");
        showCustomDialog(context);
      }else{
        print('no');
        showCustomDialogFailed(context);
      }
    });
  }
  Future getMyData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/user_profile/show?userId=$userId',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    var sum = _data['data'];
    for(var i in sum){
      print(i);
      ProfileData(
          i['userId'],
          i['userName'],
          i['passWord'],
          i['au'],
          i['name'],
          i['tel'],
          i['imgProfile']
      );
      stat = i['au'];
    }
    print(stat);
    return stat;
  }
  removeList() async{
    print("remove");
    print(aaid);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/remove?id=${aaid}',headers: header);
    print(data);
    var jsonData = json.decode(data.body);
    if(jsonData['status'] == 0){
      print("remove แล้ว");
      Navigator.pop(context);
      setState(() {

      });
    }else{
      CoolAlert.show(context: context, type: CoolAlertType.error, text: 'ทำรายการไม่สำเร็จ');
    }
  }
  @override
  void initState() {
    _fileUtil.readFile().then((id){
      this.userId = id;
      print('id funrun ${userId}');
      getMyData();
    });
    super.initState();
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
        // actions: [
        //   IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: (){
        //         if(stat == "Admin"){
        //           // Navigator.push(context, MaterialPageRoute(builder: (context) => AddTournament()));
        //         }else{
        //           showCustomDialogNot(context);
        //         }
        //       }),
        // ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getTheData(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,color: Colors.pink,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                // itemBuilder: getItem ,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: 50.0,
                          width: 50.0,
                          child: FadeInImage(
                            placeholder: AssetImage('assets/images/loading.gif'),
                            image: NetworkImage(
                              '${Config.API_URL}/test_all/image?imgAll=${snapshot.data[index].imgAll}',headers: {"Authorization": "Bearer ${_systemInstance.token}"},
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text("รายการ "+snapshot.data[index].nameAll +" ระยะทาง "+ snapshot.data[index].distance),
                        subtitle: Text(' จากวันที่ ' + snapshot.data[index].dateStart + ' ถึงวันที่ '
                            + snapshot.data[index].dateEnd),
                        onTap: () {
                          aaid = snapshot.data[index].id;
                          print(aaid);
                          if(stat == "Admin"){
                            showCustomDialogDelete(context);
                          }else{
                            saveData();
                            Navigator.of(context).pop();
                          }
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
