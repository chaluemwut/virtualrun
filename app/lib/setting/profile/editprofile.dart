import 'dart:convert';
import 'dart:io';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var userId;
  var passWord;
  var au;
  File _image;
  SystemInstance systemInstance = SystemInstance();
  SystemInstance _systemInstance = SystemInstance();
  TextEditingController userName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController tel = TextEditingController();
  final picker = ImagePicker();
  var pickedFile;

  Future getImage() async{
    pickedFile = await picker.getImage(source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0,imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getData()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/user_profile/show?userId=$userId',headers: header);
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    print(sum);
    for (var i in sum){
      passWord = i['passWord'];
      au = i['au'];
    }
  }
  Future showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('บันทึกสำเร็จ'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ปิด'),
          )
        ],
      )
  );

  void onClick(){
    print(userId);
    print(passWord);
    print(au);
    Dio dio = Dio();
    Dio dios = Dio();
    Map<String, dynamic> params = Map();
    Map<String,dynamic> par = Map();
    params['userId'] = userId;
    params['userName'] = userName.text;
    params['passWord'] = passWord.toString();
    params['name'] = name.text;
    params['tel'] = tel.text;
    params['au'] = au.toString();
    params['fileImg'] = MultipartFile.fromBytes(_image.readAsBytesSync(), filename: "filename.png");
    par['fileImg'] = MultipartFile.fromBytes(_image.readAsBytesSync(), filename: "filename.png");
    FormData formData = FormData.fromMap(params);
    FormData formDatas = FormData.fromMap(par);
    dio.options.headers["Authorization"] = "Bearer ${_systemInstance.token}";
    dios.options.headers["Authorization"] = "Bearer ${_systemInstance.token}";
    print("adsad${dio.options.headers["Authorization"] = "Bearer ${_systemInstance.token}"}");
    dio.post('${Config.API_URL}/user_profile/update_profile',data: formData).then((res) {
      Map resMap = jsonDecode(res.toString()) as Map;
      print("save");
      var data = resMap['status'];
      if(data == 1){
        showCustomDialog(context);
        setState(() {});
      }else{
        CoolAlert.show(context: context, type: CoolAlertType.error, text: 'ทำรายการไม่สำเร็จ');
      }

    });
    dios.post('${Config.API_URL}/ranking/update',data: formDatas).then((res) {
      Map resMap = jsonDecode(res.toString()) as Map;
      print("save");
      var data = resMap['status'];
      if(data == 1){
        showCustomDialog(context);
        setState(() {});
      }else{
        CoolAlert.show(context: context, type: CoolAlertType.error, text: 'ทำรายการไม่สำเร็จ');
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    userId = systemInstance.userId;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ตั้งค่าโปรไฟล์",),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
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
                    'แก้ไขโปรไฟล์',
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
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ชื่อโปรไฟล์',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  controller: tel,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'เบอร์โทรศัพท์',
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: _image == null ? Container(
                    child: Center(
                      child: Text('เลือกรูปภาพ'),
                    ),
                    color: Colors.grey[200],
                    width: 250.0,
                    height: 250.0,
                  ):Image.file(_image),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                child: Container(

                  child: RaisedButton.icon(
                    label: Text('เพิ่มรูปภาพ'),
                    icon: Icon(Icons.add_a_photo),
                    onPressed: getImage,
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
                    if(userName.text.isNotEmpty|name.text.isNotEmpty|tel.text.isNotEmpty){
                      onClick();
                    }else{
                      CoolAlert.show(context: context, type: CoolAlertType.warning, text: 'กรุณากรอกข้อมูลให้ครบถ้วน');
                    }
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
}
