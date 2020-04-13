import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19/pages/Login.dart';
import 'package:covid19/pages/Summary7days.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19/pie_chart/pie-chart_summary.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    readData();

  }

  Future<void> readData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Summary');
    await collectionReference.snapshots().listen((response) {

      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Name = ${snapshot.data['Detail']}');
      }

    });


  }
  void alertSignOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure ?"),
            content: Text("Do you want to sign out ?"),
            actions: <Widget>[
              cancelButton(),
              confirmSignOutButton(),
            ],
          );
        });
  }

  Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Login());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: "Sign Out",
      onPressed: () {
        alertSignOut();
      },
    );
  }

  Widget confirmSignOutButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        signOut();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget drawer() {
    return ListView(
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
          leading: Icon(Icons.access_time),
          title: Text('ดูรายงานย้อนหลัง 7 วัน'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    SummaryState(),
              ),
            );
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            signOutButton(),
          ],
        ),
        drawer: Drawer(child: drawer()),
        body: Container(
          color: Color.fromRGBO(30, 35, 69, 1),
          child: SafeArea(
            child: PageView(
              children: <Widget>[
                PieChartPage(),
              ],
            ),
          ),
        ) /*Container(
        color: Colors.grey[300],
        child: Center(
          child: (data != null)
              ? FadeTransition(
            opacity: _fadeInfadeOut,
            child: ListView(
              children: <Widget>[
                Container(
                    height: 100,
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: ListTile(
                          leading: Image.asset(
                            "images/coronavirus.png",
                          ),
                          title: Text(
                            "ผู้ติดเชื้อ : " + data["Confirmed"].toString() + " ราย",
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          )),
                    )),
                Container(
                    height: 100,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: ListTile(
                          leading: Image.asset(
                            "images/patient.png",
                          ),
                          title: Text(
                            "รักษาหาย : " + data["Recovered"].toString() + " ราย",
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          )),
                    )),
                Container(
                    height: 100,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: ListTile(
                          leading: Image.asset(
                            "images/death.png",
                          ),
                          title: Text(
                            "เสียชีวิต : " + data["Deaths"].toString() + " ราย",
                            style: TextStyle(
                                color: Colors.white, fontSize: 25),
                          )),
                    )),



              ],
            ),
          ) : Container(),
        ),
      ),*/
        );
  }
}
