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

void main() {
  // https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<AuthService>(
      create: (context) => AuthService(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // https://pub.dev/documentation/provider/latest/provider/Consumer-class.html
    return Consumer<ThemeProvider>(builder: (_, themeProviderRef, __) {
      return AuthWidgetBuilder(builder:
          (BuildContext context, AsyncSnapshot<FirebaseUser> userSnapshot) {
        return MaterialApp(
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
            ],
            debugShowCheckedModeBanner: false,
            // project
            routes: Routes.routes,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeProviderRef.isDarkModeOn
                ? ThemeMode.dark
                : ThemeMode.light,
            home: (userSnapshot?.data?.uid != null)
                ? ReviewsView(user: userSnapshot.data)
                : SignInView(),
            builder: (BuildContext context, Widget child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                    textScaleFactor: data.textScaleFactor > 2.0
                        ? 1.46
                        : data.textScaleFactor),
                child: child,
              );
            });
      });
    });
  }
}
