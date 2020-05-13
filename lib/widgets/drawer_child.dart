import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/login_screen.dart';
import 'package:professor_review/Screens/register_screen.dart';
import 'package:professor_review/Screens/user_profile_screen.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class DrawerChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<FirebaseUser>(context);

    return Column(children: <Widget>[
      SizedBox(height: 20),
      Icon(
        Icons.school,
        color: Colors.black54,
        size: MediaQuery.of(context).size.height * 0.2,
      ),
      SizedBox(height: 30),
      if (_user != null) ...[Text(_user.displayName)],
      if (_user == null) ...[Text("No user logged in")],
      SizedBox(height: 5),
      Divider(
        color: Colors.grey,
      ),
      Column(
        children: <Widget>[
          if (_user != null) ...[
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider(
                            create: (_) => DatabaseService.instance.userProfile(_user.uid),
                            child: UserProfileScreen(userID: _user.uid))));
              },
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              text: Text("My Profile",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            CustomButton(
              onPressed: () {
                AuthService.instance.signOut();
              },
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              text: Text("Sign out",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ],
          if (_user == null) ...[
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              text: Text("Login",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.05,
              text: Text("Register",
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ]
        ],
      )
    ]);
  }
}
