import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/util/file_util.dart';
import 'package:app/system/SystemInstance.dart';
import 'dart:convert';
import 'package:app/config/config.dart';

class RegisterRun extends StatefulWidget {
  final int aaid;

  const RegisterRun({Key key, this.aaid}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterRun();
  }
}

class _RegisterRun extends State<RegisterRun> {
  TextEditingController userNameFun = TextEditingController();
  TextEditingController passWordFun = TextEditingController();
  FileUtil _fileUtil = FileUtil();
  SystemInstance _systemInstance = SystemInstance();
  var userId;
  int _distancing = 0;
  String userName;
  int aID;
  //int km = 0;
  //int time = 0;
  //Login test = new Login();
  @override
  void initState(){
    super.initState();
    SystemInstance systemInstance = SystemInstance();
//    aid = systemInstance.aid.toString();
    userId = systemInstance.userId.toString();
    userName = systemInstance.userName;

    // _fileUtil.readFile().then((aid){
    //   this._aid = aid;
    //   print('aid save ${_aid}');
    // });
  }

  void onRegisterRun() {
    Map params = Map();
    // params['userNameFun'] = userNameFun.text;
    // params['passWordFun'] = passWordFun.text;
    // params['km'] = km.toString();
    // params['time'] = time.toString();
    params['aid'] = aID.toString();
    params['userId'] = userId.toString();
    params['distancing'] = _distancing.toString();
    print(params);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/user_run/save_run',headers: header, body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
      Widget okButton = FlatButton(
        child: Text("ปิด"),
        onPressed: () => Navigator.of(context).pop(),
      );
      AlertDialog alert = AlertDialog(
        content: Text("บันทึกสำเร็จ."),
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
    });
    setState(() {});
  }
  @override
  Widget build(BuildContext context)  {
    aID = widget.aaid;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน',
                      style: TextStyle(fontSize: 20),
                    )),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: TextField(
                //     controller: userNameFun,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'ชื่อผู้ใช้',
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                //   child: TextField(
                //     obscureText: true,
                //     controller: passWordFun,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'รหัสผ่าน',
                //     ),
                //   ),
                // ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('ลงทะเบียน'),
                      onPressed: () {
                        print(userNameFun.text);
                        print(passWordFun.text);
                        onRegisterRun();
                      },
                    )),
              ],
            )));
  }
}


/*
class RegisterMini extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterMini();
  }
}

class _RegisterMini extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  //int km = 0;
  //int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
    // params['km'] = km.toString();
    // params['time'] = time.toString();
    http.post('${Config.API_URL}/user_mini/save_mini', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Mini Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
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
                      child: Text('ลงทะเบียน'),
                      onPressed: () {
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}
class RegisterHalf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterHalf();
  }
}

class _RegisterHalf extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  // int km = 0;
  // int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
    //  params['km'] = km.toString();
    //  params['time'] = time.toString();
    http.post('${Config.API_URL}/user_half/save_half', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Half Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
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
                      child: Text('ลงทะเบียน'),
                      onPressed: () {
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}
class RegisterFull extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterFull();
  }
}

class _RegisterFull extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
//  int km = 0;
//  int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
//    params['km'] = km.toString();
//    params['time'] = time.toString();
    //Data2 hee = new Data2();
    http.post('${Config.API_URL}/user_full/save_full', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Full Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
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
                      child: Text('ลงทะเบียน'),
                      onPressed: () {
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}*/