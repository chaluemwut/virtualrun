import 'package:app/gps/location.dart';
import 'package:app/gps/stopwatch.dart';
import 'package:app/ui/ranking.dart';
import 'package:app/ui/rundata/datafun.dart';
import 'package:app/ui/runner.dart';
import 'package:app/ui/setting.dart';
import 'package:app/ui/tabbar.dart';
import 'package:app/ui/testpro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../tracker.dart';
import '../ui/profile.dart';
import '../ui/running.dart';
import '../ui/tournament.dart';
import '../ui/report.dart';
import '../maps.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
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