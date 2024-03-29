import 'package:ambulance_dashboard/Controller/authentication_base.dart';
import 'package:ambulance_dashboard/utilities/InfoDisp/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'cloud_firestore.dart';
import 'cloud_firestore_base.dart';

class Authentication extends AuthenticationBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.idTokenChanges();

  @override
  Future signInWithEmailAndPassword(
      context, String email, String password) async {
    try {
      // sign in with email and password from firebase auth
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // catch exceptios from firebase and display it to the users
    } on FirebaseAuthException catch (error) {
      Message.flutterToast(context, error.message.toString());
      // catch any exceptions occured and display
    } catch (error) {
      Message.flutterToast(context, '$error');
    }
  }

  @override
  // sign out from current auth account
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  passwordReset(BuildContext context, String email) async {
    try {
      // request for forget password and send password reset mail to user's mailbox
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      Message.flutterToast(context, "Check your Mail Box (Spam)");
      // catch exception from firebase
    } on FirebaseAuthException catch (e) {
      Message.flutterToast(context, e.message.toString());
      // catch any exception
    } catch (error) {
      Message.flutterToast(context, error.toString());
    }
  }
}
