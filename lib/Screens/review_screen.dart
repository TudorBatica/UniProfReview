import 'package:flutter/material.dart';
import 'package:professor_review/Screens/professor_profile_screen.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/services/database_service.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _review = Provider.of<Review>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 20),
          GestureDetector(
            child: Text("prof: " + _review.professorFirstName + " " + _review.professorLastName),
            onTap: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => StreamProvider(
              create: (_) => DatabaseService.instance.professor(_review.professorReference),
              child: ProfessorProfileScreen()))),
          )
        ]
        ),
      ),
    );
  }
}