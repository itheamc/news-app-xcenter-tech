import 'package:shared_preferences/shared_preferences.dart';

class SessionHandler {
  SharedPreferences? _preferences;

  SessionHandler._();

  static Future<SessionHandler> getInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return SessionHandler._().._preferences = preferences;
  }

  /// Method to store token
  Future<bool?> storeToken(String token) async {
    return _preferences?.setString("token", token);
  }

  /// Getter to store token
  String? get token => _preferences?.getString("token");

  /// Getter to checked if user is logged In
  bool get loggedIn => token != null && token!.trim().isNotEmpty;
}