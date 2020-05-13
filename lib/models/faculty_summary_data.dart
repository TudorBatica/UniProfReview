class FacultySummaryData {
  // this class is used to get and send data
  // from/to an university document in firestore

  final double averageRating;
  final String facultyName;
  final String facultyReference;

  FacultySummaryData(
      {this.averageRating, this.facultyName, this.facultyReference});

  factory FacultySummaryData.fromMap(Map<String, dynamic> map) =>
      FacultySummaryData(
          averageRating: map['avg_rating'].toDouble(),
          facultyName: map['fac_name'],
          facultyReference: map['fac_ref']);
}
