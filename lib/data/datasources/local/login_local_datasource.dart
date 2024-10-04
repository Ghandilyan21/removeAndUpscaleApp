import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDatasource {

  Future<String?> checkUserStatus() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? apiKey = prefs.getString('apiKey');
      return apiKey;
  }
}

