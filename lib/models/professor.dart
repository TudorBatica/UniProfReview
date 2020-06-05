import 'package:professor_review/models/review_summary_professor.dart';

class Professor {
  final double averageRating;
  final String documentReference;
  final String facultyName;
  final String facultyReference;
  final String firstName;
  final String lastName;
  final int numberOfReviews;
  final List<ReviewSummaryProfessor> reviews;
  final String universityName;
  final String universityReference;

  Professor(
      {this.averageRating,
      this.documentReference,
      this.facultyName,
      this.facultyReference,
      this.firstName,
      this.lastName,
      this.numberOfReviews,
      this.reviews,
      this.universityName,
      this.universityReference});

  factory Professor.fromFirestoreDocument(
          Map<String, dynamic> map, String documentReference) =>
      Professor(
          averageRating: map['avg_rating'].toDouble(),
          documentReference: documentReference,
          facultyName: map['fac_name'],
          facultyReference: map['fac_ref'],
          firstName: map['first_name'],
          lastName: map['last_name'],
          numberOfReviews: map['no_of_reviews'],
          reviews: map['reviews']
              .map<ReviewSummaryProfessor>(
                  (review) => ReviewSummaryProfessor.fromMap(review))
              .toList(),
          universityName: map['uni_name'],
          universityReference: map['uni_ref']);
}
