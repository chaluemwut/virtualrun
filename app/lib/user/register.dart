import 'package:dropdownfield/dropdownfield.dart';
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
  TextEditingController _name = TextEditingController();
  TextEditingController _tel = TextEditingController();
  String dropdown = 'User';
  String au = 'User';

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
    params['name'] = _name.text;
    params['tel'] = _tel.text;
    params['au'] = au.toString();
    //params['confirmPassWord'] = _conFirmPassWord.text;

    http.post('${Config.API_URL}/user_profile/save', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      int data = resMap['data'];
      //id = resMap['getId'];
      if (data == 0) {
        print("hello");
        showCustomDialog(context);
      } else {
        // SystemInstance systemInstance = SystemInstance();
        // systemInstance.name = _name.text;
        showCustomDialogPass(context);
      }
    });

    setState(() {});
  }
  Future showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('?????????????????????????????????????????????????????????????????????????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('?????????'),
          )
        ],
      )
  );
  Future showCustomDialogPass(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())),
            child: Text('?????????'),
          )
        ],
      )
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('?????????????????????????????????'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '????????????????????????????????????????????????????????????',
                      style: TextStyle(
                        color: Colors.blue,
                          fontSize: 20,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _userName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '??????????????????????????????',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
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
                      labelText: '????????????????????????',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '?????????????????????????????????',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: _tel,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '???????????????????????????????????????',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('???????????????????????????'),
                    onPressed: () {
                      print(_userName.text);
                      print(_passWord.text);
                      // print(_name.text);
                      onRegister();
                    },
                  ),
                ),
              ],
            )
        ),
    );
  }
}
String select = '';
final typeAUSelect = TextEditingController();

List<String> typeAU = [
  "User",
  "Admin",
];
