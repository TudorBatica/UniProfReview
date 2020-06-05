import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/faculty.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/models/review_summary_professor.dart';
import 'package:professor_review/models/review_summary_user.dart';
import 'package:professor_review/models/university.dart';

class ReviewSubmissionService {
  static final ReviewSubmissionService _instance =
      ReviewSubmissionService._privateConstructor();

  ReviewSubmissionService._privateConstructor();
  static ReviewSubmissionService get instance => _instance;

  Future<void> submitReview(Review review) async {
    Firestore.instance.runTransaction((transaction) async {
      // create the review document
      _createReviewDocument(review).then((reviewDocument) {
        // update user's profile
        _updateUserProfile(review, reviewDocument.documentID);
        // update professor's profile
        _updateProfessorProfile(review, reviewDocument.documentID)
            .then((professorsNewRating) {
          // update faculty's profile
          _updateFacultyProfileScreen(review, professorsNewRating).then(
              // update university's profile
              (facultyNewRating) =>
                  _updateUniversityProfileScreen(review, facultyNewRating));
        });
      });
    });
  }

  // create the review document
  // returns the document reference
  Future<DocumentReference> _createReviewDocument(Review review) async {
    var firestore = Firestore.instance;
    var docReference =
        await firestore.collection("reviews").add(review.toMap());
    return docReference;
  }

  // update the user profile
  Future<void> _updateUserProfile(
      Review review, String reviewDocumentReference) async {
    // create the review to be added in the user's reviews array
    var reviewSummaryData = ReviewSummaryUser(
        professorsFirstName: review.professorFirstName,
        professorsLastName: review.professorLastName,
        rating: review.rating,
        reviewReference: reviewDocumentReference,
        title: review.title);
    // get the current number of reviews
    // and the current average rating
    var usersDocument =
        Firestore.instance.collection('users').document(review.authorReference);
    int numberOfReviews;
    double currentAverageRating;
    await usersDocument.get().then((value) {
      numberOfReviews = value.data['no_of_reviews'];
      currentAverageRating = value.data['avg_rating'].toDouble();
    });
    // compute the new average rating
    var newAverageRating = currentAverageRating +
        (review.rating - currentAverageRating) / (numberOfReviews + 1);
    newAverageRating = double.parse(newAverageRating.toStringAsFixed(2));
    // update user's data
    usersDocument.updateData({
      'reviews': FieldValue.arrayUnion([reviewSummaryData.toMap()]),
      'no_of_reviews': FieldValue.increment(1),
      'avg_rating': newAverageRating
    });
  }

  // update professor's profile
  // returns professor's new avg rating
  Future<double> _updateProfessorProfile(
      Review review, String reviewDocumentReference) async {
    // create the review to be added to the professor's reviews array
    var reviewSummaryData = ReviewSummaryProfessor(
        author: review.author,
        rating: review.rating,
        reviewReference: reviewDocumentReference,
        title: review.title);
    // get the current number of reviews
    // and the current average rating
    var professorsDocument = Firestore.instance
        .collection('professors')
        .document(review.professorReference);
    int numberOfReviews;
    double currentAverageRating;
    await professorsDocument.get().then((value) {
      numberOfReviews = value.data['no_of_reviews'];
      currentAverageRating = value.data['avg_rating'].toDouble();
    });
    // compute the new average rating
    var newAverageRating = currentAverageRating +
        (review.rating - currentAverageRating) / (numberOfReviews + 1);
    newAverageRating = double.parse(newAverageRating.toStringAsFixed(2));
    // update professor's data
    professorsDocument.updateData({
      'reviews': FieldValue.arrayUnion([reviewSummaryData.toMap()]),
      'no_of_reviews': FieldValue.increment(1),
      'avg_rating': newAverageRating
    });

    return newAverageRating;
  }

  // updates faculty's profile screen
  // and returns faculty's new rating
  Future<double> _updateFacultyProfileScreen(
      Review review, double professorsNewRating) async {
    // get the and parse faculty's profile
    var facultyDocument = Firestore.instance
        .collection('faculties')
        .document(review.facultyReference);
    Faculty faculty;
    await facultyDocument
        .get()
        .then((value) => faculty = Faculty.fromMap(value.data));
    // compute the new average rating
    double newAverageRating = faculty.averageRating +
        (professorsNewRating - faculty.averageRating) /
            faculty.numberOfProfessors;
    newAverageRating = double.parse(newAverageRating.toStringAsFixed(2));
    // modify the reviewed professor in the professors array
    var professorsOldProfile;
    var professorsNewProfile;
    for (var professor in faculty.professors) {
      if (professor.professorReference != review.professorReference) {
        continue;
      }
      // keep a copy of the old object
      // so it can be removed from the array
      professorsOldProfile = professor.toMap();
      // create the updated profile
      professor.averageRating = professorsNewRating;
      professorsNewProfile = professor.toMap();
      break;
    }
    // update faculty's profile
    await facultyDocument.updateData({
      'professors': FieldValue.arrayRemove([professorsOldProfile]),
      'avg_rating': newAverageRating
    });
    facultyDocument.updateData({
      'professors': FieldValue.arrayUnion([professorsNewProfile]),
    });

    return newAverageRating;
  }

  Future<void> _updateUniversityProfileScreen(
      Review review, double facultyNewRating) async {
    // get the and parse university's profile
    var uniDocument = Firestore.instance
        .collection('universities')
        .document(review.universityReference);
    University university;
    await uniDocument
        .get()
        .then((value) => university = University.fromMap(value.data));
    // compute the new average rating
    double newAverageRating = university.averageRating +
        (facultyNewRating - university.averageRating) /
            university.faculties.length;
    newAverageRating = double.parse(newAverageRating.toStringAsFixed(2));
    // modify the faculty in the faculties array
    var facultysOldProfile;
    var facultysNewProfile;
    for (var faculty in university.faculties) {
      if (faculty.facultyReference != review.facultyReference) {
        continue;
      }
      // keep a copy of the old object
      // so it can be removed from the array
      facultysOldProfile = faculty.toMap();
      // create the updated profile
      faculty.averageRating = facultyNewRating;
      facultysNewProfile = faculty.toMap();
      break;
    }
    // update uni's profile
    await uniDocument.updateData({
      'faculties': FieldValue.arrayRemove([facultysOldProfile]),
      'avg_rating': newAverageRating
    });
    uniDocument.updateData({
      'faculties': FieldValue.arrayUnion([facultysNewProfile]),
    });
  }
}
