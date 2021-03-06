import 'dart:convert';

import 'package:app/config/config.dart';
import 'package:app/data/editdata.dart';
import 'package:app/data/full.dart';
import 'package:app/data/half.dart';
import 'package:app/data/infodata.dart';
import 'package:app/data/mini.dart';
import 'package:app/data/regis/registerrun.dart';
import 'package:app/system/SystemInstance.dart';
import 'package:app/tester/testaddtour.dart';
import 'package:app/tester/testall.dart';
import 'package:app/tester/testdata.dart';
import 'package:app/ui/profile.dart';
import 'package:app/user/login.dart';
import 'package:app/util/file_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  var gg =0;
  SharedPreferences sharedPreferences;
  var id;
  var stat = "";
  List<AllRunner> alls = List();
  List<MyRunner> runners = List();
  bool _isLoading = true;

  SystemInstance systemInstance = SystemInstance();
  SystemInstance _systemInstance = SystemInstance();

  var aaid;
  var nameAll;
  var dis;
  var type;
  var dates;
  var datee;
  var img;
  var price;
  var myId;


  Future showList()async{
    print("stat :$stat");
    if(stat == "Admin"){
      print("admin");
      Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
      var data = await http.post('${Config.API_URL}/test_all/show_all?userId=$userId',headers: header );
      if(data.statusCode == 200) {
        _isLoading = false;
        var _data = jsonDecode(data.body);
        print(_data);
        for (var i in _data) {
          AllRunner allRunner = AllRunner(
              i['id'],
              i['userId'],
              i['nameAll'],
              i['distance'],
              i['type'],
              i['dateStart'],
              i['dateEnd'],
              i['imgAll'],
              i['price'],
              i['createDate']
          );
          alls.add(allRunner);
        }
      }else{
        _isLoading = false;
        setState(() {

        });
      }
    }else if(stat == 'User'){
      Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
      var data = await http.post('${Config.API_URL}/test_all/load',headers: header );
      if(data.statusCode == 200) {
        _isLoading = false;
        var _data = jsonDecode(data.body);
        print(_data);
        var sum = _data['data'];
        for (var i in sum) {
          AllRunner allRunner = AllRunner(
              i['id'],
              i['userId'],
              i['nameAll'],
              i['distance'],
              i['type'],
              i['dateStart'],
              i['dateEnd'],
              i['imgAll'],
              i['price'],
              i['createDate']
          );
          alls.add(allRunner);
        }
      }else{
        _isLoading = false;
        setState(() {

        });
      }
    }else{

    }
    print(alls);
    setState(() {

    });
    return alls;
  }

  // Future _get()async{
  //   Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
  //   var data = await http.post('${Config.API_URL}/test_all/load',headers: header );
  //   if(data.statusCode == 200) {
  //     _isLoading = false;
  //     var _data = jsonDecode(data.body);
  //     print("all$_data");
  //     var sum = _data['data'];
  //     for (var i in sum) {
  //       AllRunner allRunner = AllRunner(
  //           i['id'],
  //           i['userId'],
  //           i['nameAll'],
  //           i['distance'],
  //           i['type'],
  //           i['dateStart'],
  //           i['dateEnd'],
  //           i['imgAll'],
  //           i['price'],
  //           i['createDate']
  //       );
  //       alls.add(allRunner);
  //       setState(() {
  //
  //       });
  //
  //     }
  //
  //   }else{
  //     _isLoading = false;
  //     setState(() {
  //
  //     });
  //   }
  //   return alls;
  // }

  Future getData()async{
    print("ididid$id");
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/user_profile/show?userId=$userId',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    var sum = _data['data'];
    for(var i in sum){
      print(i);
      ProfileData(
          i['userId'],
          i['userName'],
          i['passWord'],
          i['au'],
          i['name'],
          i['tel'],
          i['imgProfile']
      );
      stat = i['au'];
    }
    print(stat);
    showList();
    return stat;
  }
  void check(){
    print("gggg$gg");
    if(gg == 0){
      gg = userId;
      print("check");
      check();
    }else{
      print("go");
      getData();
    }
  }
  Future checkId()async{
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_run/show_run',headers: header );
    var _data = jsonDecode(data.body);
    var sum = _data['data'];
    print("_data $sum");
    for (var i in sum){
      MyRunner myRunner = MyRunner(
          i['rid'],
          i['userId'],
          i['id'],
          i['size'],
          i['createDate'],
          i['status'],
          i['imgSlip']
      );
      runners.add(myRunner);
    }
    setState(() {

    });
    print("myrun $runners");
    return runners;
  }
  Future checker()async{
    print(userId);
    print(aaid);
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_run/check?id=$aaid&userId=$userId',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    var sum = _data['status'];
    if (sum == 1){
      Navigator.push(context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  RegisterRun(aaid: aaid,name: nameAll,dis: dis,dates: dates,datee: datee,price: price,)));
    }else{
      showCustomDialogFailed(context);
    }
    setState(() {

    });
  }
  Future showCustomDialogFailed(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('?????????????????????????????????????????????????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            child: Text('?????????'),
          )
        ],
      )
  );
  Future showCustomDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('??????????????????????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('?????????'),
          )
        ],
      )
  );
  Future showCustomDialogEdit(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('??????????????????????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () =>{
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          InfoDataScreen(aid: aaid,))),
            },

            child: Text('???????????????????????????????????????????????????',style: TextStyle(color: Colors.blue),),
          ),
          FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(),
              checkList(),
              //
            },
            child: Text("???????????????",style: TextStyle(color: Colors.red),),
          ),
        ],
      )
  );
  Future checkList()async{
    print(aaid);
    var user;
    Map<String, String> header = {"Authorization": "Bearer ${_systemInstance.token}"};
    var data = await http.post('${Config.API_URL}/test_all/show_id?id=$aaid',headers: header );
    var _data = jsonDecode(data.body);
    print(_data);
    for(var i in _data){
      user = i['userId'];
    }
    print(user);
    print(userId);
    if(userId == user){
      Navigator.push(context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  EditDataScreen(aaid: aaid,name: nameAll,km: dis,type: type,dateE: datee,dateS: dates,img: img,price: price,)));
    }else{
      showCustomDialogEditFailed(context);
    }
  }
  Future showCustomDialogEditFailed(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('???????????????????????????????????????????????????'),
        actions: [
          FlatButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            child: Text('?????????'),
          )
        ],
      )
  );


  @override
  void initState() {
    // TODO: implement initState
    id = systemInstance.userId;
    print("dasd$id");
    _fileUtil.readFile().then((id){
        this.userId = id;
        print('id tournament ${userId}');
        getData();
        checkId();
        // showList();
    });


    // check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var g = _data.userId;
    //_data.user_id = 0;
    //var w = geek.geek_name = "chang";
    //_data.userId = 5;
    // print(_data.userId);
    //print(_id);


    print("gg$gg");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('??????????????????????????????'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.playlist_add),
              onPressed: (){
                if(stat == "Admin"){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddTournament()));
                }else{
                  showCustomDialog(context);
                }
              }),
        ],
      ),
      body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200.0,
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
                                          height: 70,
                                          fit:BoxFit.fill

                                      ),
                                    ),
                                    ListTile(
                                      title: Text('Fun Run'),
                                      subtitle: Text('???????????????????????? 3-5 ???????????????????????? ???????????????????????????????????????????????????????????????????????????????????????????????????'),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                  ),
                  Container(
                    width: 200.0,
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
                                  'assets/images/run2.jpg',
                                  // width: 300,
                                  height: 70,
                                  fit:BoxFit.fill

                              ),
                            ),
                            ListTile(
                              title: Text('Mini Marathon'),
                              subtitle: Text('???????????????????????? 10-11 ???????????????????????? ???????????????????????????????????????????????????????????????????????????????????????'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
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
                                  'assets/images/run3.jpg',
                                  // width: 300,
                                  height: 70,
                                  fit:BoxFit.fill

                              ),
                            ),
                            ListTile(
                              title: Text('Half Marathon'),
                              subtitle: Text('???????????????????????? 20-21 ???????????????????????? ??????????????????????????????????????????????????????????????????????????????'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 200.0,
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
                                  'assets/images/run4.jpg',
                                  // width: 300,
                                  height: 70,
                                  fit:BoxFit.fill

                              ),
                            ),
                            ListTile(
                              title: Text('Marathon'),
                              subtitle: Text('???????????????????????? 42 ???????????????????????? ??????????????????????????????????????????????????????????????????????????????'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                              child: _isLoading ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Loading(
                                    indicator: BallPulseIndicator(),
                                    size: 100.0,
                                    color: Colors.pink,
                                  ),
                                ),
                              ):ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                itemCount: alls.length,
                                  itemBuilder: (BuildContext context, int index){
                                    print(alls.length);
                                    if(runners.length == 0){
                                      print('noo');
                                      return Container(
                                        margin:EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                              child: InkWell(
                                                onTap: () {
                                                  aaid = alls[index].id;
                                                  nameAll = alls[index].nameAll;
                                                  dis = alls[index].distance;
                                                  type = alls[index].type;
                                                  dates = alls[index].dateStart;
                                                  datee = alls[index].dateEnd;
                                                  img = alls[index].imgAll;
                                                  price = alls[index].price;
                                                  print(aaid);
                                                  print(nameAll);
                                                  print(dis);
                                                  print(type);
                                                  print(dates);
                                                  print(datee);
                                                  if(stat == "Admin"){
                                                    showCustomDialogEdit(context);
                                                  }else{
                                                    checker();
                                                    // Navigator.of(context).pop();
                                                  }
                                                  // Navigator.push(context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (BuildContext context) =>
                                                  //             RegisterRun(aaid: aaid,)));
                                                },
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(8.0),
                                                        topRight: Radius.circular(8.0),
                                                      ),
                                                      child: FadeInImage(
                                                        placeholder: AssetImage('assets/images/loading.gif'),
                                                        image: NetworkImage(
                                                          '${Config.API_URL}/test_all/image?imgAll=${alls[index].imgAll}',headers: {"Authorization": "Bearer ${_systemInstance.token}"},
                                                        ),
                                                        width: 350,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text("?????????????????? "+alls[index].nameAll +" ????????????????????? "+ alls[index].distance),
                                                      subtitle: Text(' ??????????????????????????? ' + alls[index].dateStart + ' ??????????????????????????? '
                                                          + alls[index].dateEnd),

                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                          ],
                                        ),
                                      );
                                    }else{
                                      print("IDIDID$userId");
                                      print("ddd${runners[index].userId}");
                                      return Container(
                                        margin:EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                                              child: InkWell(
                                                onTap: () {
                                                  aaid = alls[index].id;
                                                  nameAll = alls[index].nameAll;
                                                  dis = alls[index].distance;
                                                  type = alls[index].type;
                                                  dates = alls[index].dateStart;
                                                  datee = alls[index].dateEnd;
                                                  img = alls[index].imgAll;
                                                  price = alls[index].price;
                                                  print(aaid);
                                                  print(nameAll);
                                                  print(dis);
                                                  print(type);
                                                  print(dates);
                                                  print(datee);
                                                  if(stat == "Admin"){
                                                    showCustomDialogEdit(context);
                                                  }else{
                                                    checker();
                                                    // Navigator.of(context).pop();
                                                  }
                                                  // Navigator.push(context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (BuildContext context) =>
                                                  //             RegisterRun(aaid: aaid,)));
                                                },
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(8.0),
                                                        topRight: Radius.circular(8.0),
                                                      ),
                                                      child: FadeInImage(
                                                        placeholder: AssetImage('assets/images/loading.gif'),
                                                        image: NetworkImage(
                                                          '${Config.API_URL}/test_all/image?imgAll=${alls[index].imgAll}',headers: {"Authorization": "Bearer ${_systemInstance.token}"},
                                                        ),
                                                        width: 350,
                                                        height: 150,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    ListTile(
                                                      title: Text("?????????????????? "+alls[index].nameAll +" ????????????????????? "+ alls[index].distance),
                                                      subtitle: Text(' ??????????????????????????? ' + alls[index].dateStart + ' ??????????????????????????? '
                                                          + alls[index].dateEnd),

                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                            userId == runners[index].userId  ? Container(
                                              width: 70,
                                              height: 30,
                                              color: Colors.blue,
                                              child: Text("???????????????????????????",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                            ):Padding(padding: EdgeInsets.zero,)
                                          ],
                                        ),
                                      );
                                    }
                                  }
                              ),
                          ),
            ),



      // ListView(
      //   children: <Widget>[
      //     Container(
      //       margin:EdgeInsets.all(8.0),
      //       child: Card(
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      //         child: InkWell(
      //           onTap: () => {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => FunRun())),
      //           },
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
      //             children: <Widget>[
      //               ClipRRect(
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(8.0),
      //                   topRight: Radius.circular(8.0),
      //                 ),
      //                 child: Image.asset(
      //                     'assets/images/run1.jpg',
      //                     // width: 300,
      //                     height: 150,
      //                     fit:BoxFit.fill
      //
      //                 ),
      //               ),
      //               ListTile(
      //                 title: Text('Fun Run'),
      //                 subtitle: Text('???????????????????????? 3-5 ???????????????????????? ???????????????????????????????????????????????????????????????????????????????????????????????????'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       margin:EdgeInsets.all(8.0),
      //       child: Card(
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      //         child: InkWell(
      //           onTap: () => {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => Mini())),
      //           },
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: <Widget>[
      //               ClipRRect(
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(8.0),
      //                   topRight: Radius.circular(8.0),
      //                 ),
      //                 child: Image.asset(
      //                     'assets/images/run2.jpg',
      //                     // width: 300,
      //                     height: 150,
      //                     fit:BoxFit.fill
      //
      //                 ),
      //               ),
      //               ListTile(
      //                 title: Text('Mini Marathon'),
      //                 subtitle: Text('???????????????????????? 10-11 ???????????????????????? ???????????????????????????????????????????????????????????????????????????????????????'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       margin:EdgeInsets.all(8.0),
      //       child: Card(
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      //         child: InkWell(
      //           onTap: () => {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => Half())),
      //           },
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: <Widget>[
      //               ClipRRect(
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(8.0),
      //                   topRight: Radius.circular(8.0),
      //                 ),
      //                 child: Image.asset(
      //                     'assets/images/run3.jpg',
      //                     // width: 300,
      //                     height: 150,
      //                     fit:BoxFit.fill
      //
      //                 ),
      //               ),
      //               ListTile(
      //                 title: Text('Half Marathon'),
      //                 subtitle: Text('???????????????????????? 20-21 ???????????????????????? ??????????????????????????????????????????????????????????????????????????????'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       margin:EdgeInsets.all(8.0),
      //       child: Card(
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      //         child: InkWell(
      //           onTap: () => {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => FullMarathon())),
      //           },
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: <Widget>[
      //               ClipRRect(
      //                 borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(8.0),
      //                   topRight: Radius.circular(8.0),
      //                 ),
      //                 child: Image.asset(
      //                     'assets/images/run4.jpg',
      //                     // width: 300,
      //                     height: 150,
      //                     fit:BoxFit.fill
      //
      //                 ),
      //               ),
      //               ListTile(
      //                 title: Text('Marathon'),
      //                 subtitle: Text('???????????????????????? 42 ???????????????????????? ??????????????????????????????????????????????????????????????????????????????'),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //
      //
      //   ],
      // ),

      // floatingActionButton:FloatingActionButton(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddTournament()));
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),
      // _isAdmin == true ?
      // FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,MaterialPageRoute(builder: (context) => AddTournament()));
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ):
    // Padding(padding: EdgeInsets.zero,),
    ]
      )
    );
  }
}

class AllRunner {
  final int id;
  final int userId;
  final String nameAll;
  final String distance;
  final String type;
  final String dateStart;
  final String dateEnd;
  final String imgAll;
  final String price;
  final String createDate;

  AllRunner(this.id, this.userId, this.nameAll, this.distance, this.type, this.dateStart, this.dateEnd, this.imgAll, this.price, this.createDate);
}

class MyRunner{
  final int rid;
  final int userId;
  final int id;
  final String size;
  final String createDate;
  final String status;
  final String imgSlip;

  MyRunner(this.rid, this.userId, this.id, this.size, this.createDate, this.status, this.imgSlip);

}