import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/gps/location.dart';
import 'package:app/gps/stopwatch.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/ui/ranking.dart';
import 'package:app/ui/rundata/datafun.dart';
import 'package:app/ui/runner.dart';
import 'file:///E:/virtualrun/app/lib/setting/setting.dart';
import 'file:///E:/virtualrun/app/lib/test/tabbar.dart';
import 'file:///E:/virtualrun/app/lib/tester/testpro.dart';
import 'package:app/user/login.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../test/tracker.dart';
import '../ui/profile.dart';
import '../ui/running.dart';
import '../ui/tournament.dart';
import '../ui/report.dart';
import '../test/maps.dart';
import 'package:http/http.dart' as http;

class Launcher extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  SystemInstance systemInstance = SystemInstance();
  SharedPreferences sharedPreferences;
  FileUtil _fileUtil = FileUtil();
  var id;
  var userId;
  SystemInstance _systemInstance = SystemInstance();
  var stat;

  List<Widget> _pageWidget = <Widget>[
    Tournament(),
    //StopWatch(),
    //Running(),
    //LocationScreen(),
    Runner(),
    //MapSample(),
    //Tracking(),

    Report(),
    //TabBarScreen(),
    RankingScreen(),
    // TestRankingScreen(),
    // DataFun(),
    // TestPro(),
    ProFile(),

    // Setting(),

  ];

  List<BottomNavigationBarItem> _menuBar
  = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.newspaper),
      title: Text('รายการวิ่ง'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.running),
      title: Text('วิ่ง'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.flagCheckered),
      title: Text('ส่งรายงาน'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.star),
      title: Text('จัดอันดับ'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.userAlt),
      title: Text('บัญชีของฉัน'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _fileUtil.readFile().then((id){
      this.userId = id;
      print('id ${userId}');
      systemInstance.token = sharedPreferences.getString("token");
      systemInstance.userId = userId;
    });
    checkToken();
    super.initState();
  }
  checkToken() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.grey[900],
        onTap: _onItemTapped,
      ),
    );
  }
}