import 'package:flutter/material.dart';
import 'package:professor_review/Screens/search_screen.dart';
import 'package:professor_review/models/user.dart';
import 'package:professor_review/widgets/drawer_child.dart';
import 'package:professor_review/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'auth_screens/auth_screen.dart';

class HomeScreen extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

    //var _user = Provider.of<User>(context);
    
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Column(children: [
        SizedBox(height: 20),
        Center(
            child: Hero(
          tag: "SearchBar",
          child: SearchBar(
            autoFocus: false,
            width: MediaQuery.of(context).size.width * 0.9,
            hintText: "Search professors or universities...",
            hintTextFontSize: 18.0,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen())),
          ),
        )),
        SizedBox(height: 50),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)))))
      ]),
      drawer: Drawer(child: DrawerChild()),
    );
  }
}
