import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:professor_review/models/faculty.dart';
import 'package:professor_review/models/professor.dart';
import 'package:professor_review/models/review.dart';
import 'package:professor_review/models/top3_universities.dart';
import 'package:professor_review/models/university.dart';
import 'package:professor_review/models/user.dart';

class DatabaseService {
  //* this is the service that fetches data
  //* from the firestore database

  static final DatabaseService instance = DatabaseService._privateConstructor();
  DatabaseService._privateConstructor();

  //* streams from the firestore database

  Stream<User> userProfile(String userID) {
    try {
      return Firestore.instance
          .collection('users')
          .document(userID)
          .snapshots()
          .asyncMap((event) => User.fromMap(event.data));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Review> review(String reviewDocumentID) {
    try {
      return Firestore.instance
          .collection('reviews')
          .document(reviewDocumentID)
          .snapshots()
          .asyncMap((event) => Review.fromMap(event.data));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Professor> professor(String professorDocumentID) {
    try {
      return Firestore.instance
          .collection('professors')
          .document(professorDocumentID)
          .snapshots()
          .asyncMap((event) =>
              Professor.fromFirestoreDocument(event.data, professorDocumentID));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Faculty> faculty(String facultyDocumentID) {
    try {
      return Firestore.instance
          .collection('faculties')
          .document(facultyDocumentID)
          .snapshots()
          .asyncMap((event) => Faculty.fromMap(event.data));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<University> university(String universityDocumentID) {
    try {
      return Firestore.instance
          .collection('universities')
          .document(universityDocumentID)
          .snapshots()
          .asyncMap((event) => University.fromMap(event.data));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<Top3Universities> topUniversities() {
    try {
      return Firestore.instance
          .collection('summary')
          .document('top_universities')
          .snapshots()
          .asyncMap((event) => Top3Universities.fromFirestoreMap(event.data));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
