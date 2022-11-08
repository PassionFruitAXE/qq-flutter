import 'package:shared_preferences/shared_preferences.dart';
import '../sqflite/domain/user.dart';

const String account = "registerAccount";

void clearStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
}

Future<User?> getCacheAccount() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  List<String>? temp = sharedPreferences.getStringList(account);
  if (temp != null) {
    return User(username: temp[0], password: temp[1], nickname: temp[2]);
  }
  return null;
}

void setCacheAccount(User user) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setStringList(
      account, [user.getUsername, user.getPassword, user.getNickname]);
}

void removeCacheAccount() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(account);
}
