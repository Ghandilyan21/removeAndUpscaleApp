import 'package:shared_preferences/shared_preferences.dart';

class SaveLocalKeyDatasource {
  void saveUserKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apiKey', key);
  }
}
