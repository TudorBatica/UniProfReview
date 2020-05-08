import 'package:flutter/material.dart';
import 'package:professor_review/widgets/drawer_child.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: Column( children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(children: <Widget>[
              Icon(
                Icons.school,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.3,
              ),
              
            ],),
          )]
        ),
        drawer: Drawer(
          child: DrawerChild()
        ),
      );
  }
} 