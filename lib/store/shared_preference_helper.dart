import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  // static const String current_language = '';
  static const String current_theme = 'system';

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme

  //Sets the theme to a new value and stores in sharedpreferences
  Future<void> changeTheme(String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(current_theme, value);
    });
  }

  //gets the current theme stored in sharedpreferences.
  //If no theme returns 'system'
  Future<String> get getCurrentTheme {
    return _sharedPreference.then((prefs) {
      String currentTheme = prefs.getString(current_theme) ?? 'system';
      return currentTheme;
    });
  }

  //Language

  //Sets the language to a new value and stores in sharedpreferences
  // Future<void> changeLanguage(String value) {
  //   return _sharedPreference.then((prefs) {
  //     return prefs.setString(current_language, value);
  //   });
  // }

  //gets the current language stored in sharedpreferences.
//   Future<String> get appCurrentLanguage {
//     return _sharedPreference.then((prefs) {
//       return prefs.getString(current_language);
//     });
//   }
// }

}

/*
class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;
  // static const String current_language = '';
  static bool darkMode = false;

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  //Theme

  //Sets the theme to a new value and stores in sharedpreferences
  Future<void> flipDarkMode() {
    return _sharedPreference.then((prefs) {
      darkMode = !(prefs.getBool('darkMode') ?? false);
      return prefs.setBool('darkMode', darkMode);
    });
  }

  //gets the current theme stored in sharedpreferences.
  //If no theme returns 'system'
  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      darkMode = prefs.getBool('darkMode') ?? false;
      return darkMode;
    });
  }

}
*/
