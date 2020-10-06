import 'package:flutter/material.dart';
import 'slide.dart';
import 'main.dart';

class Setting extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  void onClick(){

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
      ),
      body: Center(
          child: Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              child: Text('ลงชื่อออก'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ),
      ),
    );
  }
}