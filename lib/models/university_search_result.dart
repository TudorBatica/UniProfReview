import 'package:professor_review/models/university.dart';

class UniversitySearchResult {
  
  final String city;
  final String country;
  final String name;
  final String reference;

  UniversitySearchResult({this.name, this.city, this.country, this.reference});

  factory UniversitySearchResult.fromMap(Map<String, dynamic> map, String reference) =>
  UniversitySearchResult(
    city: map['city'],
    country: map['country'],
    name: map['name'],
    reference: reference
  );

}