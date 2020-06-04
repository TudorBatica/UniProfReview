import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/home_screen.dart';
import 'package:professor_review/screens/auth_screens/auth_screen.dart';
import 'package:provider/provider.dart';

//* selects the appropiate home screen 
//* that needs to be pushed 

class HomeScreenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<FirebaseUser>(context);

    return _user != null ? HomeScreen() : AuthScreen();
  }
}
