import 'dart:convert';
import 'package:app/news.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'database.dart';
class FunRun extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FunRun();
  }

}
class _FunRun extends State<FunRun> {
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
class AddFunRun extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddFunRun();
  }

}

class _AddFunRun extends State {
  TextEditingController km = TextEditingController();
  TextEditingController time = TextEditingController();

  void add() {
    Map params = Map();
    params["km"] = km.text;
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
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('เพิ่ม'),
                      onPressed: () {
                        print(km.text);
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