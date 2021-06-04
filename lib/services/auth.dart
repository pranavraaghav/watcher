import 'package:crosswalk/models/user.dart';
import 'package:crosswalk/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //
  //This converts the User Object from Firebase which has a lot of unnecessary props,
  //to a custom model in models/user.dart which takes only a couple of those props
  CrosswalkUser _userFromFirebaseUser(User user) {
    return user != null
        ? CrosswalkUser(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
          )
        : null;
  }

  //auth change user stream
  // Stream<CrosswalkUser> get user {
  //   return _auth
  //       .authStateChanges()
  //       .map((User user) => _userFromFirebaseUser(user));
  // }
  Stream<CrosswalkUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  Future<CrosswalkUser> get userA {
    return _auth.authStateChanges().first.then(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result =
          await _auth.signInAnonymously(); //Used to be AuthResult
      User user = result.user; //Used to be FirebaseUser
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserData(email, displayName);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUserDetails() async {
    CrosswalkUser user;

    return _auth.currentUser.displayName;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
