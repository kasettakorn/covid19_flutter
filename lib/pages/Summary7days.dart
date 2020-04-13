import 'package:covid19/line_chart/SummaryChart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SummaryState();
  }
}

class _SummaryState extends State<SummaryState> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("รายงานย้อนหลัง 7 วัน"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Thailand Covid-19 tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.access_time,
                color: Colors.blue,
              ),
              title: Text(
                'ดูรายงานย้อนหลัง 7 วัน',
                style: TextStyle(color: Colors.blue),
              ),
              enabled: false,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/summary7days');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          color: Color.fromRGBO(30, 35, 69, 1),
          child: SummaryChart(),
        ),
      ),
    );
  }
}
