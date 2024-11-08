import 'package:shared_preferences/shared_preferences.dart';

class CekLogin {
  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> printUsername() async {
    String? username = await getUsername();
    print('Username: $username'); // Print the username to the console
  }
}
