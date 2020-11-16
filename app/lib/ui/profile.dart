import 'package:app/system/SystemInstance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:app/util/utils.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  SystemInstance _systemInstance = SystemInstance();
  String userName;
  String _user;
  @override
  Widget build(BuildContext context) {
    SystemInstance systemInstance = SystemInstance();
    userName = systemInstance.userName;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('บัญชีของฉัน'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                    child: Container(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/images/kiw.jpg',
                          height: 50,
                          width: 200,
                          fit:BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                    child: Container(
                      child: Container(
                        child: Column(
                          children: [
                            Container(

                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),

                            Text(
                              '${userName}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                            ),
                            Divider(
                              height: 20,
                              thickness: 5,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.grey[800],
                            ),
                            Text(
                              'ระยะทางทั้งหมด',style: TextStyle(
                              fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Text(
                              'กิโลเมตร',
                              style: TextStyle(
                                fontSize: 20,
                               ),
                            ),
                            Divider(
                              height: 20,
                              thickness: 5,
                              indent: 20,
                              endIndent: 20,
                              color: Colors.grey[800],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'ข้อมูลผู้ใช้',
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  StatCard(
                                    title: 'ชาเลนจ์',
                                    achieved: 1,
                                    total: 100,
                                    color: Colors.black,
                                    image: Image.asset('assets/images/reward.jpg', width: 150),
                                  ),
                                  StatCard(
                                    title: 'เวลาเฉลี่ย',
                                    achieved: 0,
                                    total: 0,
                                    color: Theme.of(context).primaryColor,
                                    image: Image.asset('assets/images/mile.png', width: 150),
                                  ),
                                  StatCard(
                                    title: 'เวลาทั้งหมด',
                                    achieved: 100,
                                    total: 200,
                                    color: Colors.green,
                                    image: Image.asset('assets/images/time.jpg', width: 150),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('บัญชีของฉัน'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   width: 200,
//                   height: 200,
//                   padding: EdgeInsets.all(15),
//                   // decoration: BoxDecoration(
//                   //   borderRadius: BorderRadius.circular(200),
//                   //   color: Theme.of(context).primaryColor.withAlpha(50),
//                   // ),
//                   child: Image.asset(
//                     'assets/images/kiw.jpg',
//                     width: 60,
//                       fit:BoxFit.fill,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30),
//                 ),
//                 Text('${userName}'),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30),
//                 ),
//                 Divider(
//                   height: 25,
//                   color: Colors.grey[800],
//                 ),
//                 Text(
//                   'ระยะทางทั้งหมด',style: TextStyle(
//                   fontSize: 20,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10),
//                 ),
//                 Text(
//                   '0',
//                   style: TextStyle(
//                     color: Theme.of(context).primaryColor,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10),
//                 ),
//                 Text(
//                   'กิโลเมตร',style: TextStyle(
//                   fontSize: 20,
//                   ),
//                 ),
//                 Divider(
//                   height: 25,
//                   color: Colors.grey[800],
//                 ),
//                 // Container(
//                 //   child: Row(
//                 //     children: <Widget>[
//                 //       Expanded(
//                 //         flex: 3,
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.start,
//                 //           children: <Widget>[
//                 //             Text(
//                 //               'DISTANCE',
//                 //               style: TextStyle(
//                 //                 color: Theme.of(context).primaryColor,
//                 //                 fontWeight: FontWeight.bold,
//                 //               ),
//                 //             ),
//                 //             RichText(
//                 //               text: TextSpan(
//                 //                 children: [
//                 //                   TextSpan(
//                 //                     text: '8500',
//                 //                     style: TextStyle(
//                 //                       fontSize: 20,
//                 //                       color: Theme.of(context).accentColor,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                   TextSpan(
//                 //                     text: ' m',
//                 //                     style: TextStyle(
//                 //                       color: Colors.grey,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         flex: 3,
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.center,
//                 //           children: <Widget>[
//                 //             Text(
//                 //               'CALORIES',
//                 //               style: TextStyle(
//                 //                 color: Theme.of(context).primaryColor,
//                 //                 fontWeight: FontWeight.bold,
//                 //               ),
//                 //             ),
//                 //             RichText(
//                 //               text: TextSpan(
//                 //                 children: [
//                 //                   TextSpan(
//                 //                     text: '259',
//                 //                     style: TextStyle(
//                 //                       fontSize: 20,
//                 //                       color: Theme.of(context).accentColor,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                   TextSpan(
//                 //                     text: ' cal',
//                 //                     style: TextStyle(
//                 //                       color: Colors.grey,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         flex: 3,
//                 //         child: Column(
//                 //           crossAxisAlignment: CrossAxisAlignment.end,
//                 //           children: <Widget>[
//                 //             Text(
//                 //               'HEART RATE',
//                 //               style: TextStyle(
//                 //                 color: Theme.of(context).primaryColor,
//                 //                 fontWeight: FontWeight.bold,
//                 //               ),
//                 //             ),
//                 //             RichText(
//                 //               text: TextSpan(
//                 //                 children: [
//                 //                   TextSpan(
//                 //                     text: '102',
//                 //                     style: TextStyle(
//                 //                       fontSize: 20,
//                 //                       color: Theme.of(context).accentColor,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                   TextSpan(
//                 //                     text: ' bpm',
//                 //                     style: TextStyle(
//                 //                       color: Colors.grey,
//                 //                       fontWeight: FontWeight.bold,
//                 //                     ),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 // Divider(
//                 //   height: 25,
//                 //   color: Colors.grey[300],
//                 // ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                       'ข้อมูลผู้ใช้',
//                       style: TextStyle(
//                         color: Theme.of(context).accentColor,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // Row(
//                     //   children: <Widget>[
//                     //     Image.asset(
//                     //       'assets/images/down_orange.png',
//                     //       width: 20,
//                     //     ),
//                     //     Padding(
//                     //       padding: EdgeInsets.only(right: 15),
//                     //     ),
//                     //     Text(
//                     //       '500 Calories',
//                     //       style: TextStyle(
//                     //         color: Colors.orange,
//                     //         fontWeight: FontWeight.bold,
//                     //       ),
//                     //     )
//                     //   ],
//                     // )
//                   ],
//                 ),
//                 Container(
//                   height: 250,
//                   padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                   child: ListView(
//                     physics: ClampingScrollPhysics(),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     children: <Widget>[
//                       StatCard(
//                         title: 'ชาเลนจ์',
//                         achieved: 1,
//                         total: 100,
//                         color: Colors.orange,
//                         image: Image.asset('assets/images/reward.jpg', width: 150),
//                       ),
//                       StatCard(
//                         title: 'เวลาเฉลี่ย',
//                         achieved: 0,
//                         total: 0,
//                         color: Theme.of(context).primaryColor,
//                         image: Image.asset('assets/images/mile.png', width: 150),
//                       ),
//                       StatCard(
//                         title: 'Fats',
//                         achieved: 100,
//                         total: 200,
//                         color: Colors.green,
//                         image: Image.asset('assets/images/time.jpg', width: 150),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
}
//
class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[900],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor.withAlpha(100),
                  fontSize: 14,
                ),
              ),

            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 8.0,
            percent: achieved / (total < achieved ? achieved : total),
            circularStrokeCap: CircularStrokeCap.round,
            center: image,
            progressColor: color,
            backgroundColor: Theme.of(context).accentColor.withAlpha(30),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: achieved.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
              TextSpan(
                text: ' / $total',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}