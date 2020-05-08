import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/login_screen.dart';
import 'package:professor_review/Screens/register_screen.dart';
import 'package:professor_review/services/auth_service.dart';

class DrawerChild extends StatefulWidget {
  @override
  _DrawerChildState createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser();

    return Column(children: <Widget>[
      SizedBox(height: 20),
      Icon(
        Icons.school,
        color: Colors.black54,
        size: MediaQuery.of(context).size.height * 0.2,
      ),
      SizedBox(height: 30),
      FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No user logged in");
          } else {
            FirebaseUser user = snapshot.data;
            return Text(user.displayName);
          }
        },
      ),
      SizedBox(height: 5),
      Divider(
        color: Colors.grey,
      ),
      FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0)))),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                          child: Text("Register",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0)))),
                ),
              ],
            );
          } else {
            return FlatButton(
              onPressed: () {
                setState(() {});
                AuthService.instance.signOut();
              },
              child: Container(
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                      child: Text("Sign out",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)))),
            );
          }
        },
      ),
    ]);
  }
}
