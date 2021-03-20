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
  var aaid;
  List<Run> runs = List();
  var stat = "";

  Future _getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/show?type=Fun Run',headers: header );
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
      runs.add(run);
    }
    print(runs);
    return runs;
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
  Future showCustomDialogDeleteSuccess(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('ลบสำเร็จ'),
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
    print(userId);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/remove?id=${aaid}&userId=${userId}',headers: header);
    print(data);
    var jsonData = json.decode(data.body);
    if(jsonData['status'] == 0){
      print("remove แล้ว");
      Navigator.pop(context);
      showCustomDialogDeleteSuccess(context);
      setState(() {

      });
    }else{
      CoolAlert.show(context: context, type: CoolAlertType.error, text: 'ไม่ใช่รายการที่ท่านสร้าง ไม่สามารถลบได้');
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


  Widget getItem(BuildContext context, int i) {
    return _uilist[i];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fun Run'),
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
          future: _getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: Colors.pink,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                // itemBuilder: getItem ,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: InkWell(
                        child: Column(
                          children: [
                            ListTile(
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
                                  // Navigator.of(context).pop();
                                }
                                // Navigator.push(context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             RegisterRun(aaid: aaid,)));
                              },
                            ),
                          ],
                        ),
                      ),

                    );
                  }

              );
            }
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
  final int id;
  final String nameAll;
  final String distance;
  final String type;
  final String dateStart;
  final String dateEnd;
  final String imgAll;

  Run(this.id, this.nameAll, this.distance, this.type, this.dateStart, this.dateEnd, this.imgAll);
}
