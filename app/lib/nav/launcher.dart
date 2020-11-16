import 'package:app/ui/setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../ui/profile.dart';
import '../ui/running.dart';
import '../ui/tournament.dart';
import '../ui/report.dart';
import '../Maps.dart';

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
    Running(),
    Profile(),
    //MapSample(),
    Report(),
    Setting(),
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
      icon: Icon(FontAwesomeIcons.userAlt),
      title: Text('บัญชีของฉัน'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.flagCheckered),
      title: Text('ส่งรายงาน'),
    ),
    BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.cog),
      title: Text('ตั้งค่า'),
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