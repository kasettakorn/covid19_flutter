import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Homepage.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email, password;

  Widget backButton() {
    return IconButton(
      icon: Icon(Icons.navigate_before),
      iconSize: 40,
      color: Colors.blue.shade700,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget loginContainer() {
    return Center(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            appName(),
            emailForm(),
            passwordForm(),
          ],
        ),
      ),
    );
  }

  Widget appName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.local_hospital,
          size: 70,
          color: Colors.red,
        ),
        Text(
          "Thailand Covid-19 Tracker",
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700),
        ),
      ],
    );
  }

  Widget emailForm() {
    return Container(
      width: 300,
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36,
            color: Colors.blue.shade700,
          ),
          labelText: "E-mail :",
        ),
        onSaved: (String value) {
          email = value.trim();
        },
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 300,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36,
            color: Colors.blue.shade700,
          ),
          labelText: "Password :",
        ),
        onSaved: (String value) {
          password = value.trim();
        },
      ),
    );
  }

  Widget alertOKbutton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print("Authen success");
      MaterialPageRoute materialPageRoute =
      MaterialPageRoute(builder: (BuildContext context) => HomePage());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((error) {
      String title = error.code;
      String message = error.message;
      alertAuthen(title, message);
    });
  }

  void alertAuthen(String title, String message) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: ListTile(
          leading: Icon(Icons.add_alert, size: 48, color: Colors.red,),
          title: Text(title, style: TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
        ),
        content: Text(message),
        actions: <Widget>[
          alertOKbutton(),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.orange, Colors.yellow.shade500])),
          child: Stack(
            children: <Widget>[
              backButton(),
              loginContainer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          formKey.currentState.save();
          checkAuthen();
        },
      ),
    );
  }
}
