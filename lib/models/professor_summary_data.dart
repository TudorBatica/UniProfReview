class ProfessorSummaryData {
  // this class is used to get and send data
  // from/to a professor document in firestore
  final String firstName;
  final String lastName;
  final String professorReference;
  int noOfReviews;
  double avgRating;

  ProfessorSummaryData.fromMap(Map<String, dynamic> map)
      : firstName = map['first_name'],
        lastName = map['last_name'],
        professorReference = map['prof_ref'],
        noOfReviews = map['no_of_reviews'],
        avgRating = map['avg_rating'].toDouble();

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "prof_ref": professorReference,
        "no_of_reviews": noOfReviews,
        "avg_rating": avgRating
      };
}
