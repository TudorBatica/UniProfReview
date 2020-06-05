import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/home_screen.dart';
import 'package:professor_review/models/top3_universities.dart';
import 'package:professor_review/models/user.dart';
import 'package:professor_review/screens/auth_screens/auth_screen.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';

//* pushes the home screen if a user is logged
//* otherwise, pushes the auth screen

class HomeScreenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<FirebaseUser>(context);

    return _user != null
        ? MultiProvider(providers: [
            StreamProvider<User>(
                create: (_) => DatabaseService.instance.userProfile(_user.uid)),
            StreamProvider<Top3Universities>(
              create: (_) => DatabaseService.instance.topUniversities(),
            )
          ], child: HomeScreen())
        : AuthScreen();
  }
}
