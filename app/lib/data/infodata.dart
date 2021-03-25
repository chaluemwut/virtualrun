import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/data/infouser.dart';
import 'package:app/gps/location.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';


class InfoDataScreen extends StatefulWidget {
  final int aid;

  const InfoDataScreen({Key key, this.aid}) : super(key: key);
  @override
  _InfoDataScreen createState() => _InfoDataScreen();
}

class _InfoDataScreen extends State<InfoDataScreen> {
  SystemInstance _systemInstance = SystemInstance();
  SystemInstance systemInstance = SystemInstance();
  var userId;
  var aid;
  List<UserData> userDataList = List();
  var id;

  Future getData()async{
    print(aid);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_run/show_data?id=$aid',headers: header );
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    for (var i in sum){
      UserData userData = UserData(
          i['userId'],
          i['userName'],
          i['passWord'],
          i['au'],
          i['name'],
          i['tel'],
          i['imgProfile'],
      );
      userDataList.add(userData);
    }
    return userDataList;
  }

  @override
  void initState() {
    // TODO: implement initState
    userId = systemInstance.userId;
    aid = widget.aid;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายชื่อผู้สมัคร'),
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
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {

              print("null");
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
              print("have");
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
                              trailing: Icon(Icons.arrow_forward),
                              // subtitle: Text('จากรายการ ' +snapshot.data[index].nameAll + '\nเวลาที่ทำได้ ' + snapshot.data[index].time),

                            ),
                            onTap: (){
                              id = snapshot.data[index].userId;
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          InfoUserScreen(userID: id,aid: aid,)));
                            },
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
class UserData{
  final int userId;
  final String userName;
  final String passWord;
  final String au;
  final String name;
  final String tel;
  final String imgProfile;

  UserData(this.userId, this.userName, this.passWord, this.au, this.name, this.tel, this.imgProfile);
}

