import 'dart:convert';
import 'dart:io';

import 'package:app/config/config.dart';
import 'package:app/system/SystemInstance.dart';
import 'file:///E:/virtualrun/app/lib/setting/setting.dart';
import 'package:app/util/responsive_screen.dart';
import 'package:app/widget/waveclipperone.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProFile extends StatefulWidget {
  @override
  _ProFileState createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  Screen size;
  String userName;
  var pickedFile;
  final picker = ImagePicker();
  File _images;
  SystemInstance _systemInstance = SystemInstance();
  var id;
  var name = "";
  var img;
  List _listKm = List();
  List _listTime = List();
  List _list = List();
  var sumK = 0.0;
  var sumKm = "";
  var sum = 0;
  var consum = "";
  var lengthOfData = "";
  var d = 0;
  var sumTime = "";
  var len;

  Future getdata()async {Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/total_data/show_data?userId=$id', headers: header);
    var _data = jsonDecode(data.body);
    print("length:${_data.length}");
    d = _data.length;
    lengthOfData = d.toString();
    print(data);
    print("data:$_data");
      for (var i in _data) {
        _listKm.add(i['km']);
        _listTime.add(i['time']);
      }
      print("lis$_listKm");
      for (var a in _listKm) {
        print('asd$a');
        var km = double.parse(a);
        print('km${km}');
        // var zzz = NumberFormat('#0.0#');
        sumK = sumK + km;
        // sumKm = zzz.format(sumK.toString());
        sumKm = sumK.toString();
      }
      for (var b in _listTime) {
        print(b);
        var hh = b.substring(0, 2);
        var mm = b.substring(3, 5);
        var ss = b.substring(6, 8);

        var h = int.parse(hh);
        var m = int.parse(mm);
        var s = int.parse(ss);


        var htos = h * 60 * 60;
        var mtos = m * 60;
        var total = htos + mtos + s;

        sum = sum + total;
      }
      print("sum$sum");
      if(sum == 0){
        print(0);
        var sstom = sum / 60;
        var ssstom = "0${sstom}0";
        var mmm = ssstom.toString().substring(0, 2);
        var sss = ssstom.toString().substring(3, 5);
        var ssss = "0.${sss}";
        var stoi = double.parse(ssss);
        var stos = stoi * 60;
        var datas = stos.toStringAsFixed(0);
        consum = "00:${mmm}:${datas}0";
      }else{
        var sstom = sum / 60;
        print(sstom);
        var ssstom = "0${sstom}0";
        var mmm = ssstom.toString().substring(0, 2);
        var sss = ssstom.toString().substring(3, 5);
        var ssss = "0.${sss}";
        var stoi = double.parse(ssss);
        var stos = stoi * 60;
        var datas = stos.toStringAsFixed(0);
        consum = "00:${mmm}:${datas}";
      }

      print("con$consum");
      print("sumK$sumK");
      if(sumK == 0.0){
        sumKm = "0.0";
      }
      len = int.parse(lengthOfData);
      var leng = 1;
      print("les$len");
      var ava = (sum / len).toInt();
      print("avea$ava");
      if (ava == 0) {
        print("dasd");
        var stomava = "00000";
        print("dfff$stomava");
        var mmmava = stomava.toString().substring(0, 2);
        var sssava = stomava.toString().substring(3, 5);
        var ssssava = "0.${sssava}";
        var stoiava = double.parse(ssssava);
        var stosava = stoiava * 60;
        var dataava = stosava.toStringAsFixed(0);
        sumTime = "00:${mmmava}:${dataava}0";
      }else {
        var sstomava = ava / 60;
        var stomava = "0${sstomava}0";
        print(stomava);

        var mmmava = stomava.toString().substring(0, 2);
        var sssava = stomava.toString().substring(3, 5);
        var ssssava = "0.${sssava}";
        var stoiava = double.parse(ssssava);
        var stosava = stoiava * 60;
        var dataava = stosava.toStringAsFixed(0);
        sumTime = "00:${mmmava}:${dataava}";
      }
      setState(() {
        sumKm = sumKm;
        consum = consum;
        sumTime = sumTime;
      });
  }

  Future getDataProfile()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/user_profile/show?userId=$id',headers: header );
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    for(var i in sum){
      ProfileData(
          i['userId'],
          i['userName'],
          i['passWord'],
          i['au'],
          i['name'],
          i['tel'],
          i['imgProfile']
      );
      name = i['name'];
    }
    setState(() {

    });
    print(name);
    return name;
  }
  Future getImgProfile()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/user_profile/show?userId=$id',headers: header );
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    for(var i in sum){
      ProfileData(
          i['userId'],
          i['userName'],
          i['passWord'],
          i['au'],
          i['name'],
          i['tel'],
          i['imgProfile']
      );
      img = i['imgProfile'];
    }
    setState(() {

    });
    print(img);
    return img;
  }
  @override
  void initState() {
    SystemInstance systemInstance = SystemInstance();
    id = systemInstance.userId;

    getDataProfile();
    getImgProfile();
    getdata();
    img = img;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemInstance systemInstance = SystemInstance();
    userName = systemInstance.userName;
    size = Screen(MediaQuery.of(context).size);
    Future getImages()async{
      pickedFile = await picker.getImage(source: ImageSource.gallery,maxHeight: 300.0,maxWidth: 300.0);
      print('dgjdlkjlg');
      setState(() {
        if(pickedFile != null){
          _images = File(pickedFile.path);
        }
      });
    }


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: [IconButton(
          icon: Icon(Icons.settings),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
          },
        )],
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    height: 250,
                    color: Colors.pink[100],
                    child: Container(
                      child: Column(
                        children: [
                          profileWidget(),

                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('${name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text('ระยะทางทั้งหมด',style: TextStyle(fontSize: 20),),
                  Text('$sumKm',style: TextStyle(fontSize: 30),),
                  Text('กิโลเมตร',style: TextStyle(fontSize: 20),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
              ),
              Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
                color: Colors.grey[800],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.golf_course,size: 50,),
                    ),
                    Expanded(
                      child: Icon(Icons.timeline,size: 50,),
                    ),
                    Expanded(
                      child: Icon(Icons.av_timer,size: 50,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('$lengthOfData', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),

                    ),
                    Expanded(
                      child: Text('$sumTime', textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                    ),
                    Expanded(
                      child: Text('$consum',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('ชาเลนจ์', textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),

                  ),
                  Expanded(
                    child: Text('เวลาเฉลี่ย', textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                  ),
                  Expanded(
                    child: Text('เวลารวม',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),

    );

  }



  Align profileWidget() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 100.0,
              width: 100.0,
              margin: EdgeInsets.only(top: size.getWidthPx(60)),
              // child: CircleAvatar(
              //   foregroundColor: Colors.white,
              //   maxRadius: size.getWidthPx(50),
              //   backgroundColor: Colors.white,
                child: FadeInImage(
                  fadeInCurve: Curves.bounceIn,
                  placeholder: AssetImage('assets/images/loading.gif'),
                  image: NetworkImage(
                    '${Config.API_URL}/user_profile/image?imgProfile=$img',headers: {"Authorization": "Bearer ${_systemInstance.token}"},
                  ),
                  fit: BoxFit.cover,
                ),
              ),
          ),
        ],
      ),
      // ),
    );
  }
}
class ProfileData{
  final int userId;
  final String userName;
  final String passWord;
  final String au;
  final String name;
  final String tel;
  final String imgProfile;

  ProfileData(this.userId, this.userName, this.passWord, this.au, this.name, this.tel, this.imgProfile);

}