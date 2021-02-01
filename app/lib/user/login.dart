
import 'package:app/ui/profile.dart';
import 'package:app/ui/tournament.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/config.dart';
//import 'package:app/ui/nav.dart';
import 'dart:convert';
import 'package:app/util/file_util.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/main.dart';
import 'package:app/user/register.dart';


class Login extends StatefulWidget {
  // final SaveFile save;
  // Login({Key key,@required this.save}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Login();
  }
}

class _Login extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController passWord = TextEditingController();
  bool _hasUser = true;
  var userId;
  var userNameWrtie;
  var passWordWrite;
  var textRead;

  FileUtil _fileUtil = FileUtil();
  SystemInstance _systemInstance = SystemInstance();

  // Future<File> saveToFile() async{
  //   setState(() {
  //     textRead = userId.toString();
  //   });
  //   return widget.
  // }
  @override
  void initState(){

    super.initState();
    _fileUtil.readFile().then((value){
      setState(() {
        textRead = value;
        print("UserID: ${textRead}");
      });
    });
    loadData();
  }
  void loadData(){
     http.post('${Config.API_URL}/user_profile/load').then((res){
       Map resMap = jsonDecode(res.body) as Map;
       print(resMap);
     });
  }

  void logIn() {
    print("hello");
    Map params = Map();
    params['username'] = userName.text;
    params['password'] = passWord.text;
    http.post('${Config.API_URL}/authorize', body: params).then((res) {
      //int loginPass = res.body.length;
      Map resMap = jsonDecode(res.body) as Map;
      int data = resMap["data"];
      int loginPass = 0;
      if(data == 1){
        Map resMap = jsonDecode(res.body) as Map;
        SystemInstance systemInstance = SystemInstance();
        systemInstance.userId = resMap["userId"];
        systemInstance.token = resMap["token"];
        systemInstance.userName = userName.text;
        systemInstance.passWord = passWord.text;
        userId = systemInstance.userId;
        _fileUtil.writeFile(systemInstance.userId);
      }else{
        print('no');
      }

      // print(resMap);
      // int data = resMap['data'];
      // _id = resMap['getId'];
      // _data.user_id = _id;
      // print(_id);

      // _fileUtil.writeFile(_id);

      if (data == 1) {
        _hasUser = true;
        print("yes");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => First()));
        Widget okButton = FlatButton(
          child: Text("ปิด"),
          onPressed: () => Navigator.of(context).pop(),
        );
        AlertDialog alert = AlertDialog(
          content: Text("สวัสดี ${userName.text}"),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        _hasUser = false;
        print("no");

        Widget okButton = FlatButton(
          child: Text("ปิด"),
          onPressed: () => Navigator.of(context).pop(),
        );
        AlertDialog alert = AlertDialog(
          content: Text("ไม่มีชื่อผู้ใช้."),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
      setState(() {});
      print(res.body);
    }).catchError((err) {
      print(err);
      Text('error');
    });
//
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('VIRTUAL RUN'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงชื่อเข้าใช้',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: userName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ชื่อผู้ใช้',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: passWord,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('เข้าสู่ระบบ'),
                      onPressed: () {
                        print(userName.text);
                        print(passWord.text);
                        logIn();
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('ยังไม่เป็นสมาชิก'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}