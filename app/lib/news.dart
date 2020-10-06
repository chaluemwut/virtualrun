import 'package:app/main.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'slide.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';
import 'main.dart';
import 'funrun.dart';
//import 'database.dart';

class News extends StatefulWidget {
  static const routeName = '/news';

  @override
  State<StatefulWidget> createState() {
    return _NewsState();
  }
}

class _NewsState extends State<News> {
  FileUtil _fileUtil = FileUtil();

  int _id;

  @override
  void initState(){
    _fileUtil.readFile().then((id){
      this._id = id;
      print('x2${_id}');
    });
    print('x1 ${_id}');
  }

  void onSave(){
    print('button ${_id}');
  }

  List<Widget> _uiList = List();
//  int _id;
  Data _data = Data();
 // List<Data> data = List();
 // Data _data = new Data();
  //Future<Data> futureData;
 // Data geek = new Data();
  /*@override
  void initState(){
    super.initState();
   // futureData = fetctData();
  }*/
  @override
  Widget build(BuildContext context) {
    //var g = _data.userId;
    //_data.user_id = 0;
    //var w = geek.geek_name = "chang";
    _data.userId = 5;
   // print(_data.userId);
    //print(_id);




    return Scaffold(
      appBar: AppBar(
        title: Text('ข่าว'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FunRun())),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                          'assets/images/run1.jpg',
                          // width: 300,
                          height: 150,
                          fit:BoxFit.fill

                      ),
                    ),
                    ListTile(
                      title: Text('Fun Run $_id'),
                      subtitle: Text('วิ่งระยะ 5 กิโลเมตร ภายในเวลา 1 วัน'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterMini())),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                          'assets/images/run2.jpg',
                          // width: 300,
                          height: 150,
                          fit:BoxFit.fill

                      ),
                    ),
                    ListTile(
                      title: Text('Mini Marathon'),
                      subtitle: Text('วิ่งระยะ 10 กิโลเมตร ภายในเวลา 3 วัน'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterHalf())),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                          'assets/images/run3.jpg',
                          // width: 300,
                          height: 150,
                          fit:BoxFit.fill

                      ),
                    ),
                    ListTile(
                      title: Text('Half Marathon'),
                      subtitle: Text('วิ่งระยะ 21 กิโลเมตร ภายในเวลา 5 วัน'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterFull())),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      child: Image.asset(
                          'assets/images/run4.jpg',
                          // width: 300,
                          height: 150,
                          fit:BoxFit.fill

                      ),
                    ),
                    ListTile(
                      title: Text('Marathon'),
                      subtitle: Text('วิ่งระยะ 42 กิโลเมตร ภายในเวลา 7 วัน'),
                    ),
                  ],
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
                child: Text('${_id}'),
                  onPressed: () {
                onSave();
                },
            ),
           ),
          ],
      ),
    );
  }
}

/*
class Description extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Description();
  }

}
class _Description extends State{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Card(
        child: Column(
          mainAxisSize:MainAxisSize.min,
          children:<Widget>[
            const ListTile(
              leading: Icon(Icons.assignment_turned_in),
              title: Text('ระยะวิ่งทั้งหมด 5 Km ให้ใช้เวลาวิ่ง 3 วัน'),
              subtitle: Text('Code : 12345'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('เข้าใจแล้ว'),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => First()));
                  },
                )
              ],
            )
          ]
        ),
      ),
    );
  }

}
*/

class AddNews extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddNews();
  }

}
class _AddNews extends State{
  TextEditingController distance = TextEditingController(); //ใส่ใน for
 // TextEditingController description = TextEditingController(); //ใส่ใน title ของ ListTile ใน _Description
  void add(){
    Map params = Map();
    params['newsname'] =  distance.text;
  //  params['newsdescription'] = description.text;
    http.post('${Config.API_URL}/news/save',body: params).then((res){
      print(params);
    }).catchError((err){
      print(err);
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text('เพิ่มสำเร็จ'),
          actions: <Widget>[
            FlatButton(
              child: Text('ปิด'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        )
    );
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('เพิ่มข่าวสาร'),),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: distance,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ระยะทาง',
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
                        print(distance.text);
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

class RegisterFunRun extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterFunRun();
  }
}

class _RegisterFunRun extends State {
  TextEditingController userNameFun = TextEditingController();
  TextEditingController passWordFun = TextEditingController();
  //int km = 0;
  //int time = 0;
  Login test = new Login();

  void onRegisterRun() {
    Map params = Map();
    params['userNameFun'] = userNameFun.text;
    params['passWordFun'] = passWordFun.text;
   // params['km'] = km.toString();
   // params['time'] = time.toString();
    print(params);
    print('${Config.API_URL}/user_funrun/save_fun_run');

    http.post('${Config.API_URL}/user_funrun/save_fun_run', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      List a = resMap["data"];
      print(a);
//      List b = [];
//      for(int i=0;i<a.length;i++){
//        print(a[i]["id"]);
//        b.add(a[i]["id"]);
//      }
    });
    setState(() {});
  }
  @override
  Widget build(BuildContext context)  {
      // TODO: implement build
      return Scaffold(
          appBar: AppBar(
            title: Text('ลงทะเบียน'),
          ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'ลงทะเบียนเข้าแข่งขัน Fun Run',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: userNameFun,
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
                      controller: passWordFun,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'รหัสผ่าน',
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
                          print(userNameFun.text);
                          print(passWordFun.text);
                          onRegisterRun();
                        },
                      )),
                ],
              )));
    }
  }
class RegisterMini extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterMini();
  }
}

class _RegisterMini extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  //int km = 0;
  //int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
   // params['km'] = km.toString();
   // params['time'] = time.toString();
    http.post('${Config.API_URL}/user_mini/save_mini', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Mini Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
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
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}
class RegisterHalf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterHalf();
  }
}

class _RegisterHalf extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
 // int km = 0;
 // int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
  //  params['km'] = km.toString();
  //  params['time'] = time.toString();
    http.post('${Config.API_URL}/user_half/save_half', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Half Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
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
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}
class RegisterFull extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterFull();
  }
}

class _RegisterFull extends State {
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
//  int km = 0;
//  int time = 0;

  void onRegister() {
    Map params = Map();
    params['userName'] = name.text;
    params['passWord'] = pass.text;
//    params['km'] = km.toString();
//    params['time'] = time.toString();
    //Data2 hee = new Data2();
    http.post('${Config.API_URL}/user_full/save_full', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      print(resMap);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('ลงทะเบียน'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'ลงทะเบียนเข้าแข่งขัน Full Marathon',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
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
                    controller: pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'รหัสผ่าน',
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
                        print(name.text);
                        print(pass.text);
                        onRegister();
                      },
                    )),
              ],
            )));
  }
}
class Data2{
  int userId2;
  Data2(int id2){
    this.userId2 = id2;
  }
}

