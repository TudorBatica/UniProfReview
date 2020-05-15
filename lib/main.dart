import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/home_screen.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>(
              create: (_) => AuthService.instance.user),
         
        ],
        child: MaterialApp(
          title: 'Professor Review',
          theme: ThemeData(
            primaryColor: Color.fromRGBO(200, 220, 250, 1),
            accentColor: Color.fromRGBO(83, 141, 255, 1),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen(),
        ));
  }
}

