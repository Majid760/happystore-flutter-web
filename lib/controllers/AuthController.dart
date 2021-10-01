import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:admin/screens/main/components/dialogBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import 'FirebaseController.dart';

class Authentication {
  Authentication();

  String name;
  String email;
  String imageUrl;
  final _auth = FirebaseController().db_auth;
  final _db = FirebaseController().db_instance;
  // auth change user stream
  Stream<User> get onAuthStateChanged => _auth.authStateChanges();

  // GET UID
  String getCurrentUID() {
    return _auth.currentUser.uid;
  }

  // Get the user from authentication

  // UserModel _userFromUserAuth(User user) {
  //   return (user != null) ? UserModel(uid: user.uid) : null;
  // }

  // signin with google

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      // DatabaseService(uid: user.uid).createUser(user.displayName, user.email,
      //     null, user.photoURL, user.emailVerified);
      return user;
    } catch (error) {
      print(error.message.toString());
      return null;
    }
  }

  // sign in with facebook

  Future signInWithFacebook() async {
    print('your loged throud facebook!');

    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ['public_profile', 'email']);
    // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    print(result);
    if (result.status == LoginStatus.success) {
      // you are logged
      print('your loged throud facebook!');
      final AccessToken accessToken = result.accessToken;
    }
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = credential.user;
      return user;
    } on FirebaseAuthException catch (error) {
      // simply passing error code as a message
      msgDialog(context, error.message);
    }
  }

  //  register/signup the user the email and password

  Future registerWithNameEmailAndPassword(String fullName, String email,
      String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      var bytes = utf8.encode(password); // data being hashed

      var digest = sha1.convert(bytes);
      _db
          .collection('admins')
          .doc(user.uid)
          .set({
            'name': fullName,
            'email': email,
            'password': bytes.toString(),
            'date_creation': DateFormat("yyyy-MM-dd HH:mm:ss")
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      return user;
    } on FirebaseAuthException catch (error) {
      msgDialog(context, error.message);
    }
  }

  // reset password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // signout from accounts
  Future<bool> signOutUser() async {
    final user = _auth.currentUser;
    print(user.providerData[0].providerId);
    try {
      if (user.providerData[0].providerId == 'google.com') {
        await GoogleSignIn().disconnect();
      }
      await _auth.signOut();
      return Future.value(true);
    } catch (e) {
      print(e.message);
    }
  }
}
