import 'package:sqflite/sqflite.dart';
import '../domain/user.dart';
import '../services/account_service.dart';

String join(
  String path1,
  String path2,
) =>
    "$path1/$path2";

class AccountController {
  static Future<User> getAccount(String username) async {
    TableUserProvider userProvider = TableUserProvider();
    const String filename = "qq_flutter.db";
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, filename);
    await userProvider.open(path);
    User temp = await getAccountService(userProvider, username);
    userProvider.close();
    return temp;
  }

  static Future<User?> createAccount(User user) async {
    TableUserProvider userProvider = TableUserProvider();
    const String filename = "qq_flutter.db";
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, filename);
    await userProvider.open(path);
    User? temp = await createAccountService(userProvider, user);
    userProvider.close();
    return temp;
  }

  static Future<int?> updateAccount(User user) async {
    TableUserProvider userProvider = TableUserProvider();
    const String filename = "qq_flutter.db";
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, filename);
    await userProvider.open(path);
    int? temp = await updateAccountService(userProvider, user);
    userProvider.close();
    return temp;
  }

  static void removeAccount(int id) async {
    TableUserProvider userProvider = TableUserProvider();
    const String filename = "qq_flutter.db";
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, filename);
    await userProvider.open(path);
    removeAccountService(userProvider, id);
    userProvider.close();
  }
}
