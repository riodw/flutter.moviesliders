// Pub
import 'package:flutter/material.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:provider/provider.dart';
// Project
import 'package:flutter_moviesliders/constants/globals.dart';
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/services/auth_service.dart';

class SignInView extends StatelessWidget {
  // reference to scaffold
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(final BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);

    return Material(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: const DecorationImage(
                  image: const ExactAssetImage(
                      'assets/images/flutter.moviesliders.launchimage.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        // constraints: const BoxConstraints(
                        //   minHeight: 69,
                        //   minWidth: 69,
                        //   // maxHeight: 30.0,
                        //   // maxWidth: 30.0,
                        // ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          // borderRadius: BorderRadius.circular(14.0),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black54,
                              blurRadius:
                                  22, // has the effect of softening the shadow
                              spreadRadius:
                                  0, // has the effect of extending the shadow
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'Logo/Icon-App-40x40@3x.png',
                            width: 69,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'MovieSliders',
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: const Text(
                          'Peak-End Rule - People judge an experience largely based on how they felt at its peak and at its end, rather than the total sum or average of every moment of the experience.\n\nWe aim to fix that.',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      appleSignInAvailable.isAvailable
                          ? Container(
                              width: 320,
                              child: AppleSignInButton(
                                // style: ButtonStyle.white,
                                type: ButtonType.signIn,
                                onPressed: () async {
                                  await testConnection();
                                  if (!iNet) return;

                                  await AuthService()
                                      .signInWithApple(false)
                                      .then(
                                    (status) {
                                      // print(status);
                                      if (status == null) {
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                'Sorry, there was an error. Could not sign you in.'),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          : const SizedBox(
                              height: 50,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        height: 50.0,
                        minWidth: 320.0,
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () async {
                          await testConnection();
                          if (!iNet) return;

                          // final AuthService _auth = AuthService();
                          await AuthService().signInWithGoogle(false).then(
                            (status) {
                              // print(status);
                              if (status == null) {
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'Sorry, there was an error. Could not sign you in.'),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      MaterialButton(
                        height: 50.0,
                        minWidth: 320.0,
                        textColor: Colors.white,
                        child: const Text(
                          'Skip',
                        ),
                        onPressed: () async {
                          await testConnection();
                          if (!iNet) return;

                          final AuthService _auth = AuthService();
                          bool status =
                              await _auth.signInAnonymously().then((status) {
                            // setState(() {
                            //   _loading = false;
                            // });
                            return status != null;
                          });
                          if (!status) {
                            // print('Could not log in');
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: const Text('Could not log in.')));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
