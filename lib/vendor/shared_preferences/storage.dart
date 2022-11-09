import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/new.dart';
import '../sqflite/domain/user.dart';

// 缓存账号
const String cacheAccount = "registerAccount";
// 缓存5条新闻
const String cacheNews = "cacheNews";

void clearStorage() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
}

Future<User?> getCacheAccount() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // json
  String? temp = sharedPreferences.getString(cacheAccount);
  if (temp != null) {
    return User.fromMap(json.decode(temp));
  }
  return null;
}

void setCacheAccount(User user) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(cacheAccount, jsonEncode(user.toMap()));
}

void removeCacheAccount() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(cacheAccount);
}

Future<List<New>?> getCacheNews() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // List<json>
  List<String>? temp = sharedPreferences.getStringList(cacheNews);
  return temp?.map((item) => New.fromMap(json.decode(item))).toList();
}

void setCacheNews(List<New> arr) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setStringList(
      cacheNews, arr.map((item) => jsonEncode(item.toMap())).toList());
}

void removeCacheNews() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove(cacheNews);
}
