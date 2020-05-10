class FacultySummaryData {
  // this class is used to get and send data
  //from/to an university document in firestore
  double avgRating;
  final String facultyName;
  final String facultyReference;

  FacultySummaryData.fromMap(Map<String, dynamic> map)
      : avgRating = map['avg_rating'].toDouble(),
        facultyName = map['fac_name'],
        facultyReference = map['fac_ref'];

  Map<String, dynamic> toMap() => {
    'avg_rating' : avgRating,
    'fac_name' : facultyName,
    'fac_ref' : facultyReference
  };
}