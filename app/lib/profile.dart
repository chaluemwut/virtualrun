import 'package:flutter/material.dart';
import 'slide.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {

    return GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text("รางวัล 1"),
              color: Colors.teal[100],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('รางวัล 2'),
              color: Colors.teal[200],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('รางวัล 3'),
              color: Colors.teal[300],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('รางวัล 4'),
              color: Colors.teal[400],
            ),
          ],
        );
  }
  }
