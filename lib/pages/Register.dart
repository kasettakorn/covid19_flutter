import 'package:covid19/pages/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  String message, email, username, password;
  var _emailController = TextEditingController();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      setupDisplayName();
    }).catchError((error) {
      String title = error.code;
      String message = error.message;
      alertRegister(title, message);
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = username;
      response.updateProfile(userUpdateInfo);

      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => HomePage());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);

    });
  }

  void alertRegister(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 45,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color.fromRGBO(253, 171, 159, 0.5),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: TextField(
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(labelText: "E-mail"),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: TextField(
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(labelText: "Username"),
                controller: _usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Register"),
                  onPressed: () {
                    setState(() {
                      email = _emailController.text;
                      username = _usernameController.text;
                      password = _passwordController.text;
                      registerThread();
                    }); //Same as repaint(); in Java
                  },
                ),
              ],
            ),
            Center(child: Text("2020 \u00a9 Ronnakorn Hompoa")),
            (message != null) ? Text(message) : Container(),
          ],
        ),
      ),
    ));
  }
}
