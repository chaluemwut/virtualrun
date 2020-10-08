import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
class AllTournament extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Alltournament();
  }

}
class _Alltournament extends State<AllTournament> {
  List _uilist = List();

  @override
  void initState() {
    http.post("${Config.API_URL}/fun_run/check_fun").then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      List resData = resMap["data"];
      for (int i = 0; i < resData.length; i++) {
        Map data = resData[i];
        Card card = Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: (){
              if(i==0){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterFunRun(),),);
              }else if(i==1){

              }
            },
            child: Container(
              width: 300,
              height: 100,
              child: Text('${data["km"]+' '+'กิโลเมตร'}''${'ภายใน'+' '+data['time']+' '+'วัน'}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
        _uilist.add(card);
      }
      setState(() {

      });
    });
  }


  Widget getItem(BuildContext context, int i) {
    return _uilist[i];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('ชื่อหนัง'),),
      body: ListView.builder (
        itemBuilder: getItem ,
        itemCount: _uilist.length ,
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => AddTournament()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),

    );
  }
}

/*@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("รายการวิ่ง"),
      ),
      body: ListView(
        children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () =>
                  {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => FunRun())),
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                       // child: Text(),
                      ),
                      ListTile(
                        title: Text('Fun Run'),
                        subtitle: Text('วิ่งระยะ $_km กิโลเมตร ภายในเวลา $_time วัน'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: InkWell(
                onTap: () =>
                {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => FunRun())),
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // add this
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                     // child: Text(_text),
                    ),
                    ListTile(
                      title: Text('Fun Run'),
                      subtitle: Text('วิ่งระยะ $_km กิโลเมตร ภายในเวลา $_time วัน'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  }
*/
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

  void add() {
    Map params = Map();
    params["distance"] = km.text;
    params["time"] = time.text;
    http.post('${Config.API_URL}/fun_run/save_fun', body: params).then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('เพิ่มหนัง'),),
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
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('เพิ่ม'),
                      onPressed: () {
                        //add();
                      },
                    )
                ),

              ],
            )
        )
    );
  }

}
class See extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _See();
  }
}

class _See extends State<See> {
  List _uilist = List();

  @override
  void initState() {
    http.post("${Config.API_URL}/fun_run/check_fun").then((res) {
      Map resMap = jsonDecode(res.body) as Map;
      List resData = resMap["data"];
      for (int i = 0; i < resData.length; i++) {
        Map data = resData[i];
        Card card = Card(
          child: Column(
            children: <Widget>[
              Text('${data["km"] + "กิโลเมตร"}' '${"ภายใน" + data["time"] + "วัน"}'),
            ],
          ),
        );
        _uilist.add(card);
      }
      setState(() {

      });
    });
  }


  Widget getItem(BuildContext context, int i) {
    return _uilist[i];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('ชื่อหนัง'),),
      body: ListView.builder(itemBuilder: getItem, itemCount: _uilist.length,),
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
  //Login test = new Login();

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