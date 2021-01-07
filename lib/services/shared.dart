import 'package:shared_preferences/shared_preferences.dart';

//class Shared {
//  static persistBookView(isList) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    prefs.setBool('bookVieW', isList);
//  }
//
//  static getBookView() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.getInt('bookView');
//  }
//}

class Shared {
  static SharedPreferences _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  bool get bookView => _sharedPrefs.getBool("bookView") ?? true;

  set bookView(bool value) {
    _sharedPrefs.setBool("bookView", value);
  }
}

final sharedPrefs = Shared();
