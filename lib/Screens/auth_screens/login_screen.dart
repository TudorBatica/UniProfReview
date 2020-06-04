import 'package:flutter/material.dart';
import 'package:professor_review/screens/auth_screens/register_screen.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:professor_review/widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  String _email = '';
  String _password = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                  Text("Login",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColorLight)),
                  SizedBox(
                    height: 30,
                  ),
                  _loginForm(context)
                ],
              ),
            ));
  }

  Widget _loginForm(context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        TextFormField(
            // e-mail
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter you e-mail';
              } else if (!value.contains('@')) {
                return 'Please enter a valid e-mail';
              } else {
                return null;
              }
            },
            cursorColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),
            decoration: InputDecoration(
              hintText: 'E-Mail',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              setState(() => _email = value);
            }),
        SizedBox(
          height: 40,
        ),
        TextFormField(
            // password
            validator: (value) {
              if (value.length < 6) {
                return 'Password is not valid';
              } else {
                return null;
              }
            },
            cursorColor: Theme.of(context).primaryColor,
            obscureText: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              setState(() => _password = value);
            }),
        SizedBox(
          height: 40.0,
        ),
        Text(
          _errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          color: Theme.of(context).accentColor,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.055,
              child: Icon(Icons.arrow_forward, color: Colors.white)),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              setState(() => _loading = true);
              dynamic result = await AuthService.instance
                  .signInWithEmailAndPassword(_email, _password);
              if (result != null) {
                // login successful
                Navigator.pop(context);
                print("success!");
              } else {
                setState(() {
                  _loading = false;
                  _errorMessage =
                      'Sign in failed.\nPlease check your email and password and try again.';
                });
              }
            }
          },
        ),
        SizedBox(
          height: 70,
        ),
        FlatButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account?",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.w900)),
              Text(
                " Register here",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen())),
        )
      ]),
    );
  }
}
