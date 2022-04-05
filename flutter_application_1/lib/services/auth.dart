import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user_acc.dart';
import 'package:flutter_application_1/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
//creat user obj based on firebaseUser

  User_acc _userFromFirebaseUser(User user) {
    return User_acc(uid: user.uid);
  }

//auth change user stream

  Stream<User_acc?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result =
          await _auth.signInAnonymously(); //AuthResult was renamed
      User? user = result.user; //FirebaseUser was renamed and add ?after User
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'lama', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
