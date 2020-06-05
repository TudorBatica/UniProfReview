import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final AuthService _instance = AuthService._privateConstructor();
  
  AuthService._privateConstructor();
  static AuthService get instance => _instance;
  
  
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      
      var userProfile = UserUpdateInfo();
      userProfile.displayName = username;
      firebaseUser.updateProfile(userProfile);
      
      // create user's reviews document
      CollectionReference usersCollection = Firestore.instance.collection('users');
      usersCollection.document(firebaseUser.uid).setData({
      'avg_rating' : 0,
      'no_of_reviews' : 0,
      'username' : username
    }); 

      // return result
      return firebaseUser;

    } catch (e) {
      print(e.toString());
      return null;
    }
  } 

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);    
    FirebaseUser firebaseUser = result.user;
    return firebaseUser;
    } catch (e) {
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch(e) {
      print(e.toString());
    }
  }

  //user changed stream 
 Stream<FirebaseUser> get user {
    return _firebaseAuth.onAuthStateChanged;
  }



}