import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/screens/home_screen_selector.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // root widget
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>(
              create: (_) => AuthService.instance.user),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Professor Review',
          theme: ThemeData(
            fontFamily: 'Muli',
            primaryColor: Color.fromRGBO(200, 220, 250, 1),
            primaryColorDark: Color.fromRGBO(52, 54, 105, 1),
            primaryColorLight: Colors.white,
            accentColor: Color.fromRGBO(245, 123, 72, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreenSelector(),
        ));
  }
}
