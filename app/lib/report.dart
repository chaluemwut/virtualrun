import 'package:app/database.dart';
import 'package:flutter/material.dart';
import 'slide.dart';
import 'database.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Report extends StatefulWidget {
  static const routeName = '/report';
  Report({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReportState();
  }
}

class _ReportState extends State<Report> {
  Future<Data> futureData;

  @override
  void initState(){
    super.initState();
   // futureData = fetctData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ส่งรายงาน'),
      ),
      body: Center(
          child: FutureBuilder<Data>(
            future: futureData ,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data.userId.toString());
              }else{
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          )
      ),
    );
  }
}