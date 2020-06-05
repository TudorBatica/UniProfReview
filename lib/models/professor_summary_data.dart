class ProfessorSummaryData {
  // this class is used to get and send data
  // from/to a professor document in firestore

  double averageRating;
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
          professorReference: map['prof_ref']);
  
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['avg_rating'] = averageRating;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['prof_ref'] = professorReference;

    return map;
  }
}
