import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/professor_summary_data.dart';

class Faculty {
  final String city;
  final String country;
  final String documentID;
  final String name;
  final String universityName;
  final String universityReference;
  double avgRating;
  int noOfProfessors;
  var professors = List<ProfessorSummaryData>();

  Faculty.fromFirestoreDocument(DocumentSnapshot snapshot)
      : city = snapshot['city'],
        country = snapshot['country'],
        documentID = snapshot.documentID,
        name = snapshot['name'],
        universityName = snapshot['uni_name'],
        universityReference = snapshot['uni_ref'],
        avgRating = snapshot['avg_rating'].toDouble(),
        noOfProfessors = snapshot['no_of_professors'] {
    professors = snapshot['professors'].map<ProfessorSummaryData>((professor)  {
      return ProfessorSummaryData.fromMap(professor);
    }).toList();
  }
}
