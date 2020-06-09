import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// https://github.com/FirebaseExtended/flutterfire/tree/master/packages/firebase_auth/firebase_auth/example

// Auth
// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   scopes: [
//     'email',
//     // https://developers.google.com/identity/protocols/oauth2/scopes
//   ],
// );
// final FirebaseAuth _auth = FirebaseAuth.instance;

// Auth Function
// Future<FirebaseUser> _handleSignInWithGoogle() async {
//   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//   print("signed in " + user.displayName);
//   return user;
// }

class LogInView extends StatelessWidget {
  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientStart, gradientEnd],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 20));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.redAccent,
              // gradient: LinearGradient(
              //     colors: [gradientStart, gradientEnd],
              //     begin: FractionalOffset(0, 0),
              //     end: FractionalOffset(0, 1),
              //     stops: [0.0, 1.0],
              //     tileMode: TileMode.clamp),
              image: DecorationImage(
                image: ExactAssetImage('assets/images/home-2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Container(
                child: Align(
                  alignment: FractionalOffset(0.5, 0.0),
                  child: Container(
                      margin: EdgeInsets.only(top: 100.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius:
                                22.0, // has the effect of softening the shadow
                            spreadRadius:
                                1, // has the effect of extending the shadow
                            // offset: Offset(
                            // 10.0, // horizontal, move right 10
                            // 10.0, // vertical, move down 10
                            // ),
                          )
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius:
                                  0, // has the effect of softening the shadow
                              spreadRadius:
                                  0, // has the effect of extending the shadow
                            )
                          ],
                        ),
                        child: Image.asset(
                            'assets/images/moviesliders_icon.png',
                            width: 70),
                      )),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'MovieSliders',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 28.0),
                child: Text(
                  'We do all the best for your future endeavors by providing the connections you need during your job seeking process.',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.symmetric(vertical: 18.0),
                constraints: BoxConstraints(
                  maxWidth: 330.0,
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: ButtonTheme(
                minWidth: 320.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  textColor: Colors.blueAccent,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    child: Text(
                      'Continue with Apple',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ButtonTheme(
                  minWidth: 320.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () async {
                      // _handleSignInWithGoogle()
                      //     .then((FirebaseUser user) => print(user))
                      //     .catchError((e) => print(e));
                    },
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    textColor: Colors.white,
                    child: Container(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              flex: 0,
            ),
          ],
        ),
      ]),
    );
  }
}
