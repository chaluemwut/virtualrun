import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/util/file_util.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';
import 'package:image_picker/image_picker.dart';


class AddTournament extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddTournament();
  }

}

class _AddTournament extends State<AddTournament> {
  TextEditingController km = TextEditingController();
  TextEditingController time = TextEditingController();
  String dropdown = 'Fun Run';
  SystemInstance _systemInstance = SystemInstance();
  FileUtil _fileUtil = FileUtil();
  File _images;
  var pickedFile;
  final picker = ImagePicker();

  void add() {
    Map params = Map();
    params["distance"] = km.text;
    params["time"] = time.text;
    params["type"] = dropdown;
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    http.post('${Config.API_URL}/all_run/save_all',headers: header, body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      // SystemInstance systemInstance = SystemInstance();
      // systemInstance.aid = resMap["aid"];
      // _fileUtil.writeFile(systemInstance.aid);
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
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    Future getImages()async{
      pickedFile = await picker.getImage(source: ImageSource.gallery,maxHeight: 300.0,maxWidth: 300.0);
      print('dgjdlkjlg');
      setState(() {
        if(pickedFile != null){
          _images = File(pickedFile.path);
        }
      });
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('เพิ่มรายการวิ่ง'),),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: km,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ระยะทาง',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: time,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'เวลา',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: DropdownButtonFormField<String>(
                    value: dropdown,
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),

                    onChanged: (String newValue){
                      setState(() {
                        dropdown = newValue;
                      });
                    },
                    items: <String>['Fun Run', 'Mini', 'Half', 'Full']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: _images == null ? Container(
                      child: Center(
                        child: Text('ยังไม่มีรูปภาพ'),
                      ),
                      color: Colors.grey[200],
                      width: 250.0,
                      height: 250.0,
                    ):Image.file(_images),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(120, 20, 120, 20),
                  child: Container(

                    child: RaisedButton.icon(
                      label: Text('เพิ่มรูปภาพ'),
                      icon: Icon(Icons.add_a_photo),
                      onPressed: getImages,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('เพิ่ม'),
                      onPressed: () {
                        add();
                      },
                    )
                ),

              ],
            )
        )
    );
  }

}