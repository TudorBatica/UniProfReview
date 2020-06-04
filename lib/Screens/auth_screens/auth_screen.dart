import 'package:flutter/material.dart';
import 'package:professor_review/screens/auth_screens/login_screen.dart';
import 'package:professor_review/screens/auth_screens/register_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Column(
          children: <Widget>[
            _topContainer(context),
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    child: Image.asset('images/auth.png'))),
          ],
        ),
      ),
    );
  }

  Widget _topContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.center, colors: [
        Color.fromRGBO(242, 247, 249, 1),
        Color.fromRGBO(210, 215, 225, 1)
      ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
          child: Text(
            'Access\nValuable\nFeedback',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 45,
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            FlatButton(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            FlatButton(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(30.0)),
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            )
          ],
        )
      ]),
    );
  }
}
