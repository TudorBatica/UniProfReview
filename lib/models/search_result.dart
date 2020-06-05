class SearchResult {
  final String title;
  final String additionalInformation;
  final bool isUniversity;
  final String reference;

  SearchResult({this.title, this.additionalInformation, this.isUniversity, this.reference});

  factory SearchResult.fromUniversityMap(Map<String, dynamic> map, String reference)  =>
  SearchResult(
    title: map['name'],
    additionalInformation: map['city'] + ", " + map['country'],
    isUniversity: true,
    reference: reference
  );

  factory SearchResult.fromProfessorMap(Map<String, dynamic> map, String reference) =>
  SearchResult(
    title: map['first_name'] + " " + map['last_name'],
    additionalInformation: map['uni_name'],
    isUniversity: false,
    reference: reference
  );

}