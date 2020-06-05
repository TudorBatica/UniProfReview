import 'package:professor_review/models/top_university_preview_data.dart';

class Top3Universities {
  final TopUniversityPreviewData best;
  final TopUniversityPreviewData second;
  final TopUniversityPreviewData third;

  Top3Universities({this.best, this.second, this.third});

  factory Top3Universities.fromFirestoreMap(Map<String, dynamic> map) =>
      Top3Universities(
          best: TopUniversityPreviewData.fromMap(map['best']),
          second: TopUniversityPreviewData.fromMap(map['second']),
          third: TopUniversityPreviewData.fromMap(map['third']));
}
