import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/util/utils.dart';
import 'package:app/widget/widgets.dart';
import '../main.dart';
import 'package:app/system/SystemInstance.dart';

class Setting extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  String _name;
  bool isLocalNotification = false;
  bool isPushNotification = true;
  bool isPrivateAccount = true;
  String userName;

  @override
  Widget build(BuildContext context) {
    SystemInstance systemInstance = SystemInstance();
    userName = systemInstance.userName;
    _name = userName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ตั้งค่า",),
      ),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,),
        child: Container(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                accountSection(),
                pushNotificationSection(),
                getHelpSection(),
              ],
            ),
          ),
        ),
      ),

    );
  }

  SettingSection getHelpSection() {
    return SettingSection(
      headerText: "ศูนย์ช่วยเหลือ".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "ติดต่อเรา",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "ข้อเสนอแนะ",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "ลงชื่อออก",
            disableDivider: false,
            onTap: () {},
          ),
        )
      ],
    );
  }

  SettingSection accountSection() {
    return SettingSection(
      headerText: "บัญชี".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: TileRow(
            label: "ชื่อบัญชี",
            disabled: true,
            rowValue: "${_name}",
            disableDivider: false,
            onTap: () {},
          ),
        ),
        Container(
          child: TileRow(
            label: "เปลี่ยนรหัส่ผ่าน",
            disableDivider: false,
            onTap: () {},
          ),
        )
      ],
    );
  }

  SettingSection pushNotificationSection() {
    return SettingSection(
      headerText: "การแจ้งเตือน".toUpperCase(),
      headerFontSize: 15.0,
      headerTextColor: Colors.black87,
      backgroundColor: Colors.white,
      disableDivider: false,
      children: <Widget>[
        Container(
          child: SwitchRow(
            label: "แจ้งเตือน",
            disableDivider: false,
            value: isPushNotification,
            onSwitchChange: (switchStatus) {
              setState(() {
                switchStatus
                    ? isPushNotification = true
                    : isPushNotification = false;
              });
            },
            onTap: () {},
          ),
        ),
      ],
    );
  }
}