import 'package:professor_review/models/faculty_summary_data.dart';

class University {
  final double averageRating;
  final String city;
  final String country;
  final List<FacultySummaryData> faculties;
  final String name;

  University(
      {this.averageRating, this.city, this.country, this.faculties, this.name});

  factory University.fromMap(Map<String, dynamic> map) => University(
      averageRating: map['avg_rating'],
      city: map['city'],
      country: map['country'],
      faculties: map['faculties']
          .map<FacultySummaryData>(
              (faculty) => FacultySummaryData.fromMap(faculty))
          .toList(),
      name: map['name']);
}
