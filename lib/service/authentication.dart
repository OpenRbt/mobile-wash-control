import 'dart:developer';

import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<User?> authorize({required BuildContext context, String? email, String? password}) async {
    FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app("openwashing"));
    User? user;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          try {
            final UserCredential userCredential = await auth.signInWithCredential(credential);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'account-exists-with-different-credential') {
              ScaffoldMessenger.of(context).showSnackBar(
                Authentication.customSnackBar(
                  content: 'The account already exists with a different credential',
                ),
              );
            } else if (e.code == 'invalid-credential') {
              ScaffoldMessenger.of(context).showSnackBar(
                Authentication.customSnackBar(
                  content: 'Error occurred while accessing credentials. Try again.',
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                content: 'Error occurred using Google Sign In. Try again.',
              ),
            );
          }
        }
        break;
      case TargetPlatform.linux:
        final googleSignInArgs = GoogleSignInArgs(
          clientId: const String.fromEnvironment("linux_client_id"),
          redirectUri: const String.fromEnvironment("linux_redirect_url"),
          scope: 'email',
        );

        final result = await DesktopWebviewAuth.signIn(googleSignInArgs);

        String? idtoken = result?.idToken;
        String? accessToken = result?.accessToken;
        if (accessToken != null) {
          final credential = GoogleAuthProvider.credential(accessToken: accessToken, idToken: idtoken);

          final res = await auth.signInWithCredential(credential);
          user = auth.currentUser;
        }

        break;
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
      log("Singned out");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
