import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:professor_review/Screens/search_screen.dart';
import 'package:professor_review/models/user.dart';
import 'package:professor_review/screens/profile_screens/user_profile_screen.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:professor_review/widgets/custom_app_bar.dart';
import 'package:professor_review/widgets/drawer_child.dart';
import 'package:professor_review/widgets/search_bar.dart';
import 'package:professor_review/widgets/two_part_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _userProfile = Provider.of<User>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: _homeScreenAppBar(context),
        body: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.075),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // welcome text
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text('Hello,',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900)),
                Text(_userProfile.username,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // a fake search bar that leads to the search screen
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.065,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Search professors or universities...',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Theme.of(context).primaryColorDark)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  color: Theme.of(context).primaryColorLight,
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 4,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                // top universities section
                Text('Top rated',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900)),
                Text('universities',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                _topUniversitiesScrollView(context)
              ],
            ),
          ),
        ));
  }

  Widget _homeScreenAppBar(context) {
    var _user = Provider.of<FirebaseUser>(context);

    return CustomAppBar(
      height: MediaQuery.of(context).size.height * 0.11,
      leadingText: RichText(
          text: TextSpan(
              text: "Professor",
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0),
              children: [
            TextSpan(
              text: "Review",
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w900),
            )
          ])),
      trailingWidget: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StreamProvider(
                        create: (_) =>
                            DatabaseService.instance.userProfile(_user.uid),
                        child: UserProfileScreen()))),
            icon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColorDark,
            ),
            iconSize: 30.0,
          ),
          SizedBox(
            height: 1.0,
            width: 5.0,
          ),
          IconButton(
            onPressed: () => _showLogoutAlert(context),
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColorDark,
            ),
            iconSize: 30.0,
          )
        ],
      ),
    );
  }

  // alert dialog presented when the logout button
  // is pressed
  Future<void> _showLogoutAlert(context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              title: Text(
                'Log out',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColorDark),
              ),
              content: SingleChildScrollView(
                  child: Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColorDark),
              )),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    AuthService.instance.signOut();
                  },
                ),
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColorDark),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  Widget _topUniversitiesScrollView(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          TwoPartCard(
            width: MediaQuery.of(context).size.width * 0.8,
            imageHeight: MediaQuery.of(context).size.height * 0.2,
            image: Image.asset('images/university.jpg'),
            bottom: Text('University of Bucharest', 
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w800
            ),),
          ),
          SizedBox(width: 10,),
          TwoPartCard(
            width: MediaQuery.of(context).size.width * 0.8,
            imageHeight: MediaQuery.of(context).size.height * 0.2,
            image: Image.asset('images/university.jpg'),
            bottom: Text('University of Bucharest', 
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.w800
            ),),
          )
        ],
      ),
    );
  }

/*return Scaffold(
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
    );*/
}
