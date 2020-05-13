class ProfessorSummaryData {
  // this class is used to get and send data
  // from/to a professor document in firestore

  final double averageRating;
  final String firstName;
  final String lastName;
  final int numberOfReviews;
  final String professorReference;

  ProfessorSummaryData(
      {this.averageRating,
      this.firstName,
      this.lastName,
      this.numberOfReviews,
      this.professorReference});

  factory ProfessorSummaryData.fromMap(Map<String, dynamic> map) =>
      ProfessorSummaryData(
          averageRating: map['avg_rating'].toDouble(),
          firstName: map['first_name'],
          lastName: map['last_name'],
          numberOfReviews: map['no_of_reviews'],
          professorReference: map['prof_ref']);
}
