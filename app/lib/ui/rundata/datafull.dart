import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'dart:convert';

import 'infodata/datauser.dart';
import '../profile.dart';
import 'datafun.dart';
import 'datarunner.dart';

class DataFull extends StatefulWidget {
  @override
  _DataFullState createState() => _DataFullState();
}

class _DataFullState extends State<DataFull> {
  SystemInstance _systemInstance = SystemInstance();
  List<DataRunner> _dataFull = [];
  List<TotalMyData> _list = [];

  List<MyGetData> myList = [];
  var stat;
  var userId;

  Future get()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/ranking/show_type?type=Full',headers: header);
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    print("length: ${sum.length}");
    print("sum: $sum");
    for(var i in sum){
      print(i);
      MyGetData myGetData = MyGetData(
          i['rankingId'],
          i['userId'],
          i['name'],
          i['nameAll'],
          i['km'],
          i['time'],
          i['type'],
          i['imgRanking']
      );
      print(myGetData);
      myList.add(myGetData);
      print(myList);
    }
    // var len = (sum.length).toString();
    // print(len);
    // int le = int.parse(len);

    print(myList);
    return myList;
  }
  Future getData()async{
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

  @override
  void initState() {
    // TODO: implement initState
    // get();
    SystemInstance systemInstance = SystemInstance();
    userId = systemInstance.userId;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    return Column(
                      children: [
                        Card(
                          child: InkWell(
                            child: ListTile(
                              leading: Container(
                                height: 50.0,
                                width: 50.0,
                                child: FadeInImage(
                                  placeholder: AssetImage('assets/images/loading.gif'),
                                  image: NetworkImage(
                                    '${Config.API_URL}/user_profile/image?imgProfile=${snapshot.data[index].imgProfile}',headers: {"Authorization": "Bearer ${_systemInstance.token}"},
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(snapshot.data[index].name),
                              subtitle: Text('จากรายการ ' +snapshot.data[index].nameAll + ' เวลาที่ทำได้ ' + snapshot.data[index].time),
                              onTap: (){
                                if(stat == 'Admin'){
                                  print("yes");
                                  var user = snapshot.data[index].userId;
                                  print("user$user");
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DataUserScreen(userId: user,)));
                                }
                              },
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
