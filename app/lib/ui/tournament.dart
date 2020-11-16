import 'package:app/data/full.dart';
import 'package:app/data/half.dart';
import 'package:app/data/mini.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/funrun.dart';
import 'package:app/data/add.dart';

class Tournament extends StatefulWidget {
  static const routeName = '/news';
  final int userId;

  const Tournament({Key key, this.userId}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _Tournament();
  }
}

class _Tournament extends State<Tournament> {
  FileUtil _fileUtil = FileUtil();
  var userId;
  int gg;

  @override
  void initState(){
    _fileUtil.readFile().then((id){
      this.userId = id;
      print('id tournament ${userId}');
    });
  }

  List<Widget> _uiList = List();
//  int _id;
//  Data _data = Data();
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
    //_data.userId = 5;
    // print(_data.userId);
    //print(_id);
    gg = userId;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('รายการวิ่ง'),

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
                      title: Text('Fun Run'),
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
                      MaterialPageRoute(builder: (context) => Mini())),
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
                      MaterialPageRoute(builder: (context) => Half())),
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
                      MaterialPageRoute(builder: (context) => FullMarathon())),
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


        ],
      ),
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

/*class AddNews extends StatefulWidget{
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


class Data2{
  int userId2;
  Data2(int id2){
    this.userId2 = id2;
  }
}
*/
