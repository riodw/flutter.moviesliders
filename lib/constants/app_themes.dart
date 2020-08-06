import 'package:flutter/material.dart';

// ThemeData lightTheme = ThemeData(

//   primaryColor: Colors.blueAccent,
//   primaryColorDark: Colors.blueGrey[400],
//   accentColor: Colors.indigo,
//   buttonColor: Colors.blueAccent,
//   visualDensity: VisualDensity.adaptivePlatformDensity,
// );

class AppThemes {
  AppThemes._();

  /*
   * FONT 
   */
  static const String font1 = 'Hind';
  // static String font1 = 'ProductSans';
  static const String font2 = 'Georgia';

  // static const Color primaryBlue = Colors.blueAccent;
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);
  static const Color blackPearl = Color.fromRGBO(30, 31, 43, 1);
  // static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  // static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  // static const Color nevada = Color.fromRGBO(105, 109, 119, 1);
  static const Color ebonyClay = Color.fromRGBO(40, 42, 58, 1);

  /*
   * LIGHT THEME
   */
  //constants color range for light theme
  static const Color _lightPrimaryColor = Colors.blueAccent;
  static const Color _lightSecondaryColor = Colors.indigo;

  //Background Colors
  static const Color _lightBackgroundColor = whiteLilac;
  // static const Color _lightBackgroundSecondaryColor = Colors.white;
  // static const Color _lightBackgroundAlertColor = blackPearl;
  // static const Color _lightBackgroundErrorColor = Colors.red;
  // static const Color _lightBackgroundSuccessColor = Colors.green;

  //Text Colors
  static const Color _lightTextColor = Colors.black;
  // static const Color _lightAlertTextColor = Colors.black;
  // static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  // static const Color _lightBorderColor = nevada;

  //Icon Color
  // static const Color _lightIconColor = Colors;

  //form input colors
  // static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  // static const Color _lightBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextTheme _lightTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 30.0,
        color: _lightTextColor,
        fontWeight: FontWeight.normal,
        fontFamily: font1),
    headline2: TextStyle(
        fontSize: 30.0,
        color: _lightTextColor,
        fontWeight: FontWeight.bold,
        fontFamily: font2),
    headline3: TextStyle(
        fontSize: 22.0,
        color: _lightTextColor,
        fontWeight: FontWeight.bold,
        fontFamily: font1),
    headline4:
        TextStyle(fontSize: 18.0, color: Colors.grey[600], fontFamily: font1),
    // headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    // headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    bodyText1:
        TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: font1),
    bodyText2:
        TextStyle(fontSize: 12.0, color: Colors.grey[600], fontFamily: font1),

    button: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        // fontWeight: FontWeight.w600,
        fontFamily: font1),
    // subtitle1: TextStyle(fontSize: 16.0, color: _lightTextColor),
    // caption: TextStyle(fontSize: 12.0, color: _lightPrimaryColor),
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: font1,
    scaffoldBackgroundColor: _lightBackgroundColor,
    // primarySwatch: _lightPrimaryColor,
    // accentColor: _lightSecondaryColor, //prefix icon color form input on focus

    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: _lightPrimaryColor,
    // ),
    appBarTheme: AppBarTheme(
      color: _lightPrimaryColor,
      // iconTheme: IconThemeData(color: _lightTextColor),
      // textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightBackgroundColor,
      secondary: _lightSecondaryColor,
    ),
    // snackBarTheme:
    //     SnackBarThemeData(backgroundColor: _lightBackgroundAlertColor),
    // iconTheme: IconThemeData(
    //     color: _lightIconColor,
    //     ),
    // popupMenuTheme: PopupMenuThemeData(color: _lightPrimaryColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    // unselectedWidgetColor: _lightPrimaryColor,
    // inputDecorationTheme: InputDecorationTheme(
    //   //prefixStyle: TextStyle(color: _lightIconColor),
    //   // border: OutlineInputBorder(
    //   //     borderSide: BorderSide(width: 1.0),
    //   //     borderRadius: BorderRadius.all(
    //   //       Radius.circular(8.0),
    //   //     )),
    //   // enabledBorder: OutlineInputBorder(
    //   //   // borderSide: BorderSide(color: _lightBorderColor, width: 1.0),
    //   //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   // ),
    //   // focusedBorder: OutlineInputBorder(
    //   //   borderSide: BorderSide(color: _lightBackgroundSecondaryColor),
    //   //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   // ),
    //   // errorBorder: OutlineInputBorder(
    //   //   // borderSide: BorderSide(color: _lightBorderErrorColor),
    //   //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   // ),
    //   // focusedErrorBorder: OutlineInputBorder(
    //   //   // borderSide: BorderSide(color: _lightBorderErrorColor),
    //   //   borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   // ),
    //   fillColor: _lightPrimaryColor,
    //   //focusColor: _lightPrimaryColor,
    // ),
  );

  /*
   * DARK THEME
   */

  //constants color range for dark theme
  static const Color _darkPrimaryColor = Colors.blueGrey;
  static const Color _darkSecondaryColor = Colors.blueGrey;

  //Background Colors
  static const Color _darkBackgroundColor = ebonyClay;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  // static const Color _darkBackgroundSecondaryColor =
  //     Color.fromRGBO(0, 0, 0, .6);
  // static const Color _darkBackgroundAlertColor = Colors.black;
  // static const Color _darkBackgroundErrorColor =
  //     Color.fromRGBO(255, 97, 136, 1);
  // static const Color _darkBackgroundSuccessColor =
  //     Color.fromRGBO(186, 215, 97, 1);

  // Text Colors
  static const Color _darkTextColor = Colors.white;
  // static const Color _darkAlertTextColor = Colors.black;
  // static const Color _darkTextSecondaryColor = Colors.black;

  // Border Color
  // static const Color _darkBorderColor = nevada;

  // Icon Color
  // static const Color _darkIconColor = Colors.white;

  // static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  // static const Color _darkBorderActiveColor = _darkPrimaryColor;
  // static const Color _darkBorderErrorColor = brinkPink;

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 30.0,
        color: _darkTextColor,
        fontWeight: FontWeight.normal,
        fontFamily: font1),
    headline2: TextStyle(
        fontSize: 30.0,
        color: _darkTextColor,
        fontWeight: FontWeight.bold,
        fontFamily: font2),
    headline3: TextStyle(
        fontSize: 22.0,
        color: _darkTextColor,
        fontWeight: FontWeight.bold,
        fontFamily: font1),
    headline4: TextStyle(fontSize: 18.0, color: Colors.grey, fontFamily: font1),
    // headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: _darkTextColor),
    // headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: _darkTextColor),
    bodyText1:
        TextStyle(fontSize: 14.0, color: _darkTextColor, fontFamily: font1),
    bodyText2: TextStyle(fontSize: 12.0, color: Colors.grey, fontFamily: font1),

    button: TextStyle(
        fontSize: 16.0,
        color: _darkTextColor,
        // fontWeight: FontWeight.w600,
        fontFamily: font1),
    // subtitle1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    // caption: TextStyle(fontSize: 12.0, color: _darkBackgroundAppBarColor),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,
    // primarySwatch: _darkPrimaryColor,
    // accentColor: _darkSecondaryColor, //prefix icon color form input on focus

    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   backgroundColor: _darkPrimaryColor,
    // ),
    appBarTheme: AppBarTheme(
      color: _darkBackgroundAppBarColor,
      // iconTheme: IconThemeData(color: _darkTextColor),
      // textTheme: _darkTextTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryVariant: _darkBackgroundColor,

      // secondary: _darkSecondaryColor,
    ),
    // snackBarTheme: SnackBarThemeData(
    //     contentTextStyle: TextStyle(color: Colors.white),
    //     backgroundColor: _darkBackgroundAlertColor),
    // iconTheme: IconThemeData(
    //   color: Colors.white, //_darkIconColor,
    // ),
    // popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _darkPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    // unselectedWidgetColor: _darkPrimaryColor,
    // inputDecorationTheme: InputDecorationTheme(
    //   prefixStyle: TextStyle(color: _darkIconColor),
    //   //labelStyle: TextStyle(color: nevada),
    //   border: OutlineInputBorder(
    //       borderSide: BorderSide(width: 1.0),
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(8.0),
    //       )),
    //   enabledBorder: OutlineInputBorder(
    //     // borderSide: BorderSide(color: _darkBorderColor, width: 1.0),
    //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     // borderSide: BorderSide(color: _darkBorderActiveColor),
    //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   ),
    //   errorBorder: OutlineInputBorder(
    //     // borderSide: BorderSide(color: _darkBorderErrorColor),
    //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     // borderSide: BorderSide(color: _darkBorderErrorColor),
    //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //   ),
    //   fillColor: _darkInputFillColor,
    //   //focusColor: _darkBorderActiveColor,
    // ),
  );
}
