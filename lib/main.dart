import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Pubs
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Project
import 'package:flutter_moviesliders/services/services.dart';
import 'package:flutter_moviesliders/constants/constants.dart';
import 'package:flutter_moviesliders/views/sign_in_view.dart';
import 'package:flutter_moviesliders/views/reviews_view.dart';

// https://flutter.dev/docs/development/ui/interactive#managing-state

void main() async {
  // https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html
  WidgetsFlutterBinding.ensureInitialized();

  final appleSignInAvailable = await AppleSignInAvailable.check();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider<ConnectivityService>(
          create: (context) => ConnectivityService(),
        ),
      ],
      child: Provider<AppleSignInAvailable>.value(
        value: appleSignInAvailable,
        child: MovieSliders(),
      ),
    ),
  );
}

class MovieSliders extends StatelessWidget {
  const MovieSliders({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    // https://pub.dev/documentation/provider/latest/provider/Consumer-class.html

    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          builder: (final BuildContext context,
              final AsyncSnapshot<FirebaseUser> userSnapshot) {
            return StreamProvider<ConnectivityStatus>(
              create: (context) =>
                  ConnectivityService().connectionStatusController.stream,
              child: MaterialApp(
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                ],
                debugShowCheckedModeBanner: false,
                routes: Routes.routes,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: themeProviderRef.isDarkModeOn
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: (userSnapshot?.data?.uid != null)
                    ? ReviewsView(user: userSnapshot.data)
                    : SignInView(),
                builder: (final BuildContext context, final Widget child) {
                  final MediaQueryData data = MediaQuery.of(context);
                  return MediaQuery(
                      data: data.copyWith(
                          textScaleFactor: data.textScaleFactor > 2.0
                              ? 1.46
                              : data.textScaleFactor),
                      child: child);
                },
              ),
            );
          },
        );
      },
    );
  }
}
