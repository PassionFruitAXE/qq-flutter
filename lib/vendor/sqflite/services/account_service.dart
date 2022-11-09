import '../domain/user.dart';

// 通过用户名获取账号信息
Future<User> getAccountService(TableUserProvider provider, String username) {
  return provider.getUserByUsername(username);
}

// 创建新账号
Future<User?> createAccountService(
    TableUserProvider provider, User user) async {
  User temp = await getAccountService(provider, user.getUsername);
  if (temp.getUsername != user.getUsername) {
    return provider.insert(user);
  }
  return null;
}

Future<int?> updateAccountService(TableUserProvider provider, User user) async {
  User temp = await getAccountService(provider, user.getUsername);
  if (temp.getUsername == user.getUsername) {
    return provider.update(user);
  }
  return null;
}

// 通过id删除账号
void removeAccountService(TableUserProvider provider, int id) {
  provider.delete(id);
}
