import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:app/config.dart';
// import 'package:app/news.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'launcher.dart';
import 'database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var _id;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      //home: Login(),
      home: Login(),
    );
  }
}

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
  Data _data = new Data();
  int _id;
  bool _hasUser = true;

  FileUtil _fileUtil = FileUtil();

  void logIn() {
    print("hello");
    Map params = Map();
    params['userName'] = userName.text;
    params['passWord'] = passWord.text;
    print('${Config.API_URL}/user_profile/login');
    http.post('${Config.API_URL}/user_profile/login', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
      int data = resMap['data'];
      _id = resMap['getId'];
      _data.user_id = _id;
      print("${_data.userId}dhee");
      // print(_id);

      _fileUtil.writeFile(_id);

      print(data);
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
          content: Text("สวัสดี $_id."),
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
    });
//
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('RMUTI มินิมาราธอน'),
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

class Register extends StatefulWidget {
  //final SaveFile save;
  //Register({Key key,@required this.save}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Register();
  }
}

class _Register extends State<Register> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _passWord = TextEditingController();

  // TextEditingController _conFirmPassWord = TextEditingController();
  // int id;
  /* @override
    void initState() {
      super.initState();
      widget.save.readCounter().then((int value) {
        setState(() {
          id = value;
        });
      });
    }
    Future<File> _showfile() {
      setState(() {
        id = id ;
      });

      // Write the variable as a string to the file.
      return widget.save.writeCounter(id);
    }*/

  void onRegister() {
    Map params = Map();
    params['userName'] = _userName.text;
    params['passWord'] = _passWord.text;
    //params['confirmPassWord'] = _conFirmPassWord.text;

    http.post('${Config.API_URL}/user_profile/save', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      int data = resMap['data'];
      //id = resMap['getId'];
      if (data == 0) {
        print("hello");
        Widget okButton = FlatButton(
          child: Text("ปิด"),
          onPressed: () => Navigator.of(context).pop(),
        );
        AlertDialog alert = AlertDialog(
          content: Text("มีชื่อผู้ใช้อยู่แล้ว."),
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
        Widget okButton = FlatButton(
          child: Text("ปิด"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())),
        );
        AlertDialog alert = AlertDialog(
          content: Text("บักทึกสำเร็จ."),
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
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('สมัครสมาชิก'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'สมัครสมาชิก',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _userName,
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
                    controller: _passWord,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
                    ),
                  ),
                ),
                /*
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    obscureText: true,
                    controller: _conFirmPassWord,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ยืนยันรหัสผ่าน',
                    ),
                  ),
                ),*/
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('ลงทะเบียน'),
                    onPressed: () {
                      print(_userName.text);
                      print(_passWord.text);
                      onRegister();
                    },
                  ),
                ),
              ],
            )));
  }
}

class First extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _First();
  }
}

class _First extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.purple,
        textTheme: TextTheme(body1: TextStyle(color: Colors.red)),
      ),
      title: 'First Flutter App',
      initialRoute: '/', // สามารถใช้ home แทนได้
      routes: {
        // Maps.routename:(context) => Maps(),
        Launcher.routeName: (context) => Launcher(),
      },
    );
  }
}

class Data {
  String geekName;
  int userId;

  Data() {
    this.userId = 10;
  }

  String get geek_name {
    return geekName;
  }

  set geek_name(String name) {
    this.geekName = name;
  }

  int get user_id {
    return userId;
  }

  set user_id(int id) {
    this.userId = id;
  }
}
