import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/top_university_preview_data.dart';

class HomeScreenDataService {
  // updates the data for the home screen
  //! to fetch data for the home screen, use the DatabaseService

  static final HomeScreenDataService _instance =
      HomeScreenDataService._privateConstructor();
  static final CollectionReference _homeScreenDataCollection =
      Firestore.instance.collection('summary');
  HomeScreenDataService._privateConstructor();

  static HomeScreenDataService get instance => _instance;

  // updated top rated uni document
  Future<void> updateTopRatedUniversities(
      TopUniversityPreviewData universityData) async {
    // fetch the array of top universities
    var universities = List<TopUniversityPreviewData>();
    await _homeScreenDataCollection
        .document('top_universities')
        .get()
        .then((value) {
      universities = value.data['universities']
          .map<TopUniversityPreviewData>(
              (university) => TopUniversityPreviewData.fromMap(university))
          .toList();
    });
    // update target university entry
    var oldUniProfile;
    var newUniProfile;
    for (var uni in universities) {
      if (uni.reference != universityData.reference) {
        continue;
      }
      // store a copy of the old entry
      // so it can be deleted
      oldUniProfile = uni.toMap();
      uni.rating = universityData.rating;
      newUniProfile = uni.toMap();
    }
    // sort by rating (descending)
    universities.sort((uniB, uniA) => uniA.rating.compareTo(uniB.rating));
    // remove old entry
    await _homeScreenDataCollection.document('top_universities').updateData({
      'universities': FieldValue.arrayRemove([oldUniProfile])
    });
    // add updated entry
    _homeScreenDataCollection.document('top_universities').updateData({
      'universities': FieldValue.arrayUnion([newUniProfile])
    });
    // update top 3
    String index;
    for (int i = 0; i < 3; i++) {
      if (i == universities.length) {
        break;
      }
      if (i == 0) {
        index = 'best';
      } else if (i == 1) {
        index = 'second';
      } else if (i == 2) {
        index = 'third';
      }
      _homeScreenDataCollection
          .document('top_universities')
          .updateData({index: universities[i].toMap()});
    }
  }
}
