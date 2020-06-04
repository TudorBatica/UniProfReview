import 'package:flutter/material.dart';
import 'package:professor_review/screens/auth_screens/login_screen.dart';
import 'package:professor_review/services/auth_service.dart';
import 'package:professor_review/widgets/loading.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // to identify the register form
  bool _loading = false;

  // registration data
  String _email;
  String _username;
  String _password;
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
                SizedBox(
                  height: 20,
                ),
                Text("Register",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColorLight)),
                SizedBox(
                  height: 20,
                ),
                _registerForm(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
                          .registerWithEmailAndPassword(
                              _email, _password, _username);
                      if (result != null) {
                        // signed up successfully
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _loading = false;
                          _errorMessage =
                              "Registration failed.\n Please check that the e-mail address is valid\n and try again";
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already signed up?",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        " Login here",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                )
              ],
            )));
  }

  Widget _registerForm() {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: [
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
              // username
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a username';
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
                hintText: 'Username ',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                setState(() => _username = value);
              }),
          SizedBox(
            height: 40,
          ),
          TextFormField(
              // password
              validator: (value) {
                if (value.length < 6) {
                  return 'Please enter a longer password';
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
            height: 40,
          ),
          TextFormField(
            // confirm password
            validator: (value) {
              if (value != _password) {
                return 'Passwords don\'t match';
              } else {
                return null;
              }
            },
            cursorColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
            obscureText: true,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),
            decoration: InputDecoration(
              hintText: 'Confirm password',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ])));
  }
}
