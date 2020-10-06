// Pub
import 'package:flutter/material.dart';
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
    return Material(
      child: Stack(children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 20));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: const BoxDecoration(
              image: const DecorationImage(
                image: const ExactAssetImage('assets/images/home-2.jpg'),
                fit: BoxFit.cover,
              ),
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
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              22.0, // has the effect of softening the shadow
                          spreadRadius:
                              0, // has the effect of extending the shadow
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset('Logo/flutter.moviesliders.logo.png',
                          width: 69),
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
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 320.0,
                    textColor: Colors.blueAccent,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'Continue with Apple',
                      // style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await testConnection();
                      if (!iNet) return;

                      final AuthService _auth = AuthService();
                      bool status =
                          await _auth.signInWithGoogle().then((status) {
                        // setState(() {
                        //   _loading = false;
                        // });
                        return status != null;
                      });
                      if (!status) {
                        // print('Could not log in');
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: const Text('Could not log in.')));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    height: 50.0,
                    minWidth: 320.0,
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Text(
                      'Continue with Google',
                      // style: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    onPressed: () async {
                      await testConnection();
                      if (!iNet) return;

                      final AuthService _auth = AuthService();
                      bool status =
                          await _auth.signInWithGoogle().then((status) {
                        // setState(() {
                        //   _loading = false;
                        // });
                        return status != null;
                      });
                      if (!status) {
                        // print('Could not log in');
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: const Text('Could not log in.')));
                      }
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
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: const Text('Could not log in.')));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
