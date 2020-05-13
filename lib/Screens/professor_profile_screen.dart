import 'package:flutter/material.dart';
import 'package:professor_review/Screens/faculty_profile_screen.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';

class ProfessorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _professor = Provider.of<Professor>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(_professor.firstName),
              SizedBox(height: 50),
              GestureDetector(
                child: Text(_professor.facultyName),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StreamProvider(
                            create: (_) => DatabaseService.instance
                                .faculty(_professor.facultyReference),
                            child: FacultyProfileScreen()))),
              )
            ],
          ),
        ));
  }
}
