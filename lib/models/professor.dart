class Professor {
  final String documentID;
  final String facultyReference;
  final String firstName;
  final String lastName;
  final String universityReference;
  int numberOfReviews;
  double averageRating;

  Professor(
      {this.firstName,
      this.lastName,
      this.documentID,
      this.facultyReference,
      this.universityReference,
      this.numberOfReviews,
      this.averageRating});

  Professor.fromFirestoreMap(Map<String, dynamic> map,
      String universityReference, String facultyReference)
      : documentID = map['prof_ref'],
        facultyReference = facultyReference,
        firstName = map['first_name'],
        lastName = map['last_name'],
        universityReference = universityReference,
        numberOfReviews = map['no_of_reviews'],
        averageRating = map['avg_rating'].toDouble();
}
