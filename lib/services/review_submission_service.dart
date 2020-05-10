import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/faculty.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/models/university.dart';
import 'package:tuple/tuple.dart';

class ReviewSubmissionService {
  static final ReviewSubmissionService _instance =
      ReviewSubmissionService._privateConstructor();

  ReviewSubmissionService._privateConstructor();
  static ReviewSubmissionService get instance => _instance;

  Future submitReview(Professor professor, Review review) async {
    double profNewAvgRating = await _updateProfessorDocument(professor, review);
    Tuple2 facultyRatings =
        await _updateFacultyDocument(professor, review, profNewAvgRating);
    await _updateUniversityDocument(
        professor, review, facultyRatings.item2, facultyRatings.item1);
  }

  // returns professor's new average rating
  Future<double> _updateProfessorDocument(
      Professor professor, Review review) async {
    var firestore = Firestore.instance;
    // add the review to the professor's collection
    var professorsReviews =
        firestore.collection('professors/' + professor.documentID + '/reviews');
    professorsReviews.add(review.map);

    // compute professor's new average rating
    double profNewAvgRating;
    if (professor.averageRating == 0) {
      profNewAvgRating = review.rating;
    } else {
      profNewAvgRating = (professor.numberOfReviews * professor.averageRating +
              review.rating) /
          (professor.numberOfReviews + 1);
    }

    // upload the updated data to firestore
    var professorsDocument =
        firestore.collection('professors').document(professor.documentID);
    professorsDocument.updateData({
      "avg_rating": profNewAvgRating,
      "no_of_reviews": FieldValue.increment(1)
    });

    return profNewAvgRating;
  }

  // returns a tuple where the first value is the faculty's old average rating
  // and the second value is the updated average rating
  Future<Tuple2> _updateFacultyDocument(
      Professor professor, Review review, double profNewAvgRating) async {
    var firestore = Firestore.instance;

    // retrieve the faculty
    var facultyDocument = await firestore
        .collection('faculties')
        .document(professor.facultyReference)
        .get();
    var faculty = Faculty.fromFirestoreDocument(facultyDocument);
    print(faculty.city + " " + faculty.country + " " +faculty.documentID + " " +faculty.noOfProfessors.toString() + 
    "" + faculty.universityName + " " + faculty.universityReference + " " + faculty.professors.length.toString());
    // compute new average rating
    double facNewAvgRating;
    if (faculty.avgRating == 0) {
      facNewAvgRating = review.rating;
    } else {
      facNewAvgRating = faculty.avgRating +
          ((profNewAvgRating - professor.averageRating) /
              faculty.noOfProfessors);
    }
    print("new avg" + facNewAvgRating.toString());
    print(faculty.professors[0].toMap());
    print(faculty.professors[0].professorReference);
    print(professor.documentID);
    // update professor's summary data
    var toDelete;
    var toAdd;
    for (int i = 0; i < faculty.professors.length; i++) {
      if (faculty.professors[i].professorReference == professor.documentID) {
        toDelete = faculty.professors[i].toMap();
        print("toDelete done");
        faculty.professors[i].avgRating = profNewAvgRating;
        faculty.professors[i].noOfReviews ++;
        toAdd = faculty.professors[i].toMap();
        break;
      }
    }
    print(toAdd.toString());
    print(toDelete.toString());
    print("did sth in update faculty document");
    // upload updated data to firestore
    await firestore.collection('faculties').document(faculty.documentID).updateData(
        {"avg_rating": facNewAvgRating, 
        "professors": FieldValue.arrayRemove([toDelete])});
    firestore.collection('faculties').document(faculty.documentID).updateData({
      "professors": FieldValue.arrayUnion([toAdd])
    });


    return Tuple2<double, double>(faculty.avgRating, facNewAvgRating);
  }
}

Future _updateUniversityDocument(Professor professor, Review review,
    double facNewAvgRating, double facOldAvgRating) async {
  // retrieve the university
  var firestore = Firestore.instance;
  var universityDocument = await firestore
      .collection('universities')
      .document(professor.universityReference)
      .get();
  var university = University.fromFirestoreDocument(universityDocument);

  // compute new university average rating
  double newUniAvgRating;
  if (university.avgRating == 0) {
    newUniAvgRating = review.rating;
  } else {
    newUniAvgRating =
        university.avgRating + ((facNewAvgRating - facOldAvgRating) / university.noOfFaculties);
  }
  // update faculty's summary data
  var toAdd;
  var toRemove;
  for (var faculty in university.faculties) {
    if (faculty.facultyReference == professor.facultyReference) {
      toRemove = faculty.toMap();
      faculty.avgRating = facNewAvgRating;
      toAdd = faculty.toMap();
      break;
    }
  }

  print("did sth in uni update");
  // upload the updated data to firestore
  await firestore
      .collection('universities')
      .document(university.documentID)
      .updateData(
          {"avg_rating": newUniAvgRating, "faculties": FieldValue.arrayRemove([toRemove])});
  firestore
      .collection('universities')
      .document(university.documentID)
      .updateData(
          {"faculties": FieldValue.arrayUnion([toAdd])});
}
