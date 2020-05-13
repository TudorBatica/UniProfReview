import 'package:professor_review/models/professor_summary_data.dart';

class Faculty {
  final double averageRating;
  final String city;
  final String country;
  final String name;
  final int numberOfProfessors;
  final List<ProfessorSummaryData> professors;
  final String universityName;
  final String universityReference;

  Faculty(
      {this.averageRating,
      this.city,
      this.country,
      this.name,
      this.numberOfProfessors,
      this.professors,
      this.universityName,
      this.universityReference});

  factory Faculty.fromMap(Map<String, dynamic> map) => Faculty(
      averageRating: map['avg_rating'].toDouble(),
      city: map['city'],
      country: map['country'],
      name: map['name'],
      numberOfProfessors: map['no_of_professors'],
      professors: map['professors']
          .map<ProfessorSummaryData>(
              (professor) => ProfessorSummaryData.fromMap(professor))
          .toList(),
      universityName: map['uni_name'],
      universityReference: map['uni_ref']);
}
