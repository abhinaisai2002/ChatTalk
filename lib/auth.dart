import 'package:chatting_application/Database_USer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth _instance = FirebaseAuth.instance;
  GoogleSignIn googlesignin = GoogleSignIn();
  Stream<User> get user {
    return _instance.authStateChanges();
  }

  // register with email and password;
  Future register(String email, String password) async {
    try {
      UserCredential user = await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      User userId = user.user;
      if (userId.emailVerified == false) {
        await userId.sendEmailVerification();
      }
      await Users(u: userId).addUserDetails();
      return userId;
    } catch (e) {
      return e;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _instance.signOut();
    } catch (e) {
      return null;
    }
  }

  // google sign - in
  Future googleSign() async {
    try {
      GoogleSignInAccount _account = await googlesignin.signIn();
      GoogleSignInAuthentication usr = await _account.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: usr.accessToken, idToken: usr.idToken);
      UserCredential _google =
          await (_instance.signInWithCredential(credential));
      if (_instance.currentUser.emailVerified == false) {
        await _instance.currentUser.sendEmailVerification();
      }
      Users().getUserDetails.listen((event) async {
        if (event.data() == null) {
          await Users(u: _google.user).addUserDetails();
        }
      });

      return _google.user;
    } catch (e) {
      return null;
    }
  }

  // sign out google
  Future googleSignOut() async {
    return await googlesignin.signOut();
  }

  // sign in with email and password
  Future singIn(String email, String password) async {
    try {
      UserCredential user = await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      User userId = user.user;
      return userId;
    } catch (e) {
      return e;
    }
  }
}
