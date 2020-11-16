import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/config/config.dart';
//import 'package:app/ui/nav.dart';
import 'dart:convert';
import 'package:app/util/file_util.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/user/login.dart';


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