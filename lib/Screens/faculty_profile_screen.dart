import 'package:flutter/material.dart';
import 'package:professor_review/Screens/university_profile_screen.dart';
import 'package:professor_review/models/faculty.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';

class FacultyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _faculty = Provider.of<Faculty>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(_faculty.averageRating.toString()),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            child: Text(_faculty.universityName),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => StreamProvider(
                create: (_) => DatabaseService.instance.university(_faculty.universityReference),
                child: UniversityProfileScreen()
                )
            )),
            )
        ],
      )),
    );
  }
}
