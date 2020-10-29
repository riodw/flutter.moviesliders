// Pub
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase user one-time fetch
  // Future<FirebaseUser> get getUser => _auth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  // Future<bool> isAdmin() async {
  //   bool _isAdmin = false;
  //   await _auth.currentUser().then((user) async {
  //     DocumentSnapshot adminRef =
  //         await _db.collection('admin').document(user?.uid).get();
  //     if (adminRef.exists) {
  //       _isAdmin = true;
  //     }
  //   });
  //   return _isAdmin;
  // }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }

  // Create Anonymous User
  Future signInAnonymously() async {
    return await _auth.signInAnonymously();
  }

  /*
  Google signin
  */

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      // scopes: [ // https://developers.google.com/identity/protocols/oauth2/scopes
      //   'email',
      // ],
      );

  /// Sign in with Google
  Future<FirebaseUser> signInWithGoogle(convert) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AuthResult result;

      if (convert) {
        final currentUser = await _auth.currentUser();
        // https://youtu.be/JLl5M4N7ftM?t=4028
        result = await currentUser.linkWithCredential(credential);
      } else {
        result = await _auth.signInWithCredential(credential);
      }

      // final FirebaseUser user = result.user;

      return result.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  /*
  Apple signin
  */

  // Determine if Apple Signin is available on device
  // Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();
  // Sign in with Apple
  Future<FirebaseUser> signInWithApple(convert) async {
    try {
      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      if (appleResult.error != null) {
        print(appleResult.error);
        return null;
      }

      final AuthCredential credential =
          OAuthProvider(providerId: 'apple.com').getCredential(
        accessToken:
            String.fromCharCodes(appleResult.credential.authorizationCode),
        idToken: String.fromCharCodes(appleResult.credential.identityToken),
      );

      AuthResult result;

      if (convert) {
        final currentUser = await _auth.currentUser();
        // https://youtu.be/JLl5M4N7ftM?t=4028
        result = await currentUser.linkWithCredential(credential);
      } else {
        result = await _auth.signInWithCredential(credential);
      }

      return result.user;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
