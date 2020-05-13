import 'package:flutter/material.dart';
import 'package:professor_review/models/university.dart';
import 'package:provider/provider.dart';

class UniversityProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _university = Provider.of<University>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(_university.city)
          ],
        ),
      ),
    );
  }
}
