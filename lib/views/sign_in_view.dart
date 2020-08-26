// Pub
import 'package:flutter/material.dart';
// Project
import 'package:flutter_moviesliders/services/auth_service.dart';

class SignInView extends StatefulWidget {
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  static bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height - 20));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/home-2.jpg'),
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
                    padding: EdgeInsets.all(5),
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
                    child: Image.asset('assets/images/moviesliders_icon.png',
                        width: 60),
                  ),
                ),
              ),
              Column(
                children: [
                  const Text(
                    'MovieSliders',
                    style: TextStyle(
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
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
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
                    child: Container(
                      child: const Text(
                        'Continue with Apple',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
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
                      AuthService _auth = AuthService();
                      bool status =
                          await _auth.signInWithGoogle().then((status) {
                        setState(() {
                          _loading = false;
                        });
                        return status != null;
                      });
                      if (!status) {
                        print('Could not log in');
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Could not log in.')));
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
                      AuthService _auth = AuthService();
                      bool status =
                          await _auth.signInAnonymously().then((status) {
                        setState(() {
                          _loading = false;
                        });
                        return status != null;
                      });
                      if (!status) {
                        print('Could not log in');
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Could not log in.')));
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
