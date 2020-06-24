import 'package:flutter/material.dart';
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_moviesliders/models/models.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase user one-time fetch
  Future<FirebaseUser> get getUser => _auth.currentUser();

  // Firebase user a realtime stream
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  // TODO
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
  Future<FirebaseUser> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = result.user;

      return user;
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
  /// Sign in with Apple
  // Future<FirebaseUser> appleSignIn() async {
  //   try {
  //     final AuthorizationResult appleResult =
  //         await AppleSignIn.performRequests([
  //       AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //     ]);

  //     if (appleResult.error != null) {
  //       // handle errors from Apple
  //     }

  //     final AuthCredential credential =
  //         OAuthProvider(providerId: 'apple.com').getCredential(
  //       accessToken:
  //           String.fromCharCodes(appleResult.credential.authorizationCode),
  //       idToken: String.fromCharCodes(appleResult.credential.identityToken),
  //     );

  //     AuthResult firebaseResult = await _auth.signInWithCredential(credential);
  //     FirebaseUser user = firebaseResult.user;

  //     // Update user data
  //     updateUserData(user);

  //     return user;
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }
}
