import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/faculty_summary_data.dart';

class University {
  
  final String city;
  final String country;
  final String name;
  final String documentID;
  double avgRating;
  int noOfFaculties;
  var faculties = List<FacultySummaryData>();

  University.fromFirestoreDocument(DocumentSnapshot snapshot):
  city = snapshot['city'],
  country = snapshot['country'],
  name = snapshot['name'],
  documentID = snapshot.documentID,
  avgRating = snapshot['avg_rating'].toDouble(),
  noOfFaculties = snapshot['no_of_fac'] {
    faculties = snapshot['faculties'].map<FacultySummaryData>((faculty) {
      return FacultySummaryData.fromMap(faculty);
    }).toList();
  }
}