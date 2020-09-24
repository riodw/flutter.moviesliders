import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//
import 'package:firebase_auth/firebase_auth.dart';
// Project
// import 'package:flutter_moviesliders/models/models.dart';
import 'package:flutter_moviesliders/services/auth_service.dart';

//https://www.youtube.com/watch?v=B0QX2woHxaU from this tutorial
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<FirebaseUser>) builder;

  @override
  Widget build(final BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);

    return StreamBuilder<FirebaseUser>(
      stream: authService.user,
      builder: (final BuildContext context,
          final AsyncSnapshot<FirebaseUser> snapshot) {
        final FirebaseUser user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
           */
          return MultiProvider(
            providers: [
              Provider<FirebaseUser>.value(value: user),
              // StreamProvider<UserModel>.value(
              //     value: AuthService().streamFirestoreUser(user))
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
