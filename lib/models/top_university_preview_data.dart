class TopUniversityPreviewData {
  final String name;
  double rating;
  final String reference;

  TopUniversityPreviewData({this.name, this.rating, this.reference});

  factory TopUniversityPreviewData.fromMap(Map<String, dynamic> map) =>
      TopUniversityPreviewData(
          name: map['name'] ?? "-",
          rating: map['rating']?.toDouble() ?? 0.0,
          reference: map['reference'] ?? "-");

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['rating'] = rating;
    map['reference'] = reference;

    return map;
  }
}
