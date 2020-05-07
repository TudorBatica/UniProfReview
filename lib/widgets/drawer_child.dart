import 'package:flutter/material.dart';
import 'package:professor_review/Screens/login_screen.dart';
import 'package:professor_review/Screens/register_screen.dart';

class DrawerChild extends StatefulWidget {

  final String username;
  DrawerChild({Key key, this.username}) : super(key : key);

  @override
  _DrawerChildState createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 20),
      Icon(
        Icons.school,
        color: Colors.black54,
        size: MediaQuery.of(context).size.height * 0.2,
      ),
      SizedBox(height: 30),
      Text(
        widget.username
      ),
      SizedBox(height: 5),
      Divider(
        color: Colors.grey,
      ),
      FlatButton(
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );},
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0
              )
              ))
        ),
      ),
       FlatButton(
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        );},
        child: Container(
          color: Theme.of(context).primaryColor,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Center(
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0
              )
              ))
        ),
      )
    ]);
  }
}