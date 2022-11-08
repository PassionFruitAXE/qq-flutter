import 'package:sqflite/sqflite.dart';

// 表名
const String tableName = 'table_user';
// _id字段
const String columnId = 'id';
// username字段
const String columnUsername = 'username';
// password字段
const String columnPassword = 'password';
// nickname字段
const String columnNickname = 'nickname';

class User {
  int? id;
  String? _username;
  String? _password;
  String? _nickname;

  get getUsername => _username;

  get getPassword => _password;

  get getNickname => _nickname;

  User({this.id, username, password, nickname}) {
    _username = username;
    _password = password;
    _nickname = nickname;
  }

  Map<String, dynamic> toMap() => (<String, dynamic>{
        columnId: id,
        columnUsername: _username,
        columnPassword: _password,
        columnNickname: _nickname
      });

  User.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    _username = map[columnUsername];
    _password = map[columnPassword];
    _nickname = map[columnNickname];
  }
}

class TableUserProvider {
  Database? db;

  // 打开数据库，并创建table_user表
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $tableName(
        $columnId integer primary key autoincrement,
        $columnUsername text not null,
        $columnPassword text not null,
        $columnNickname text not null)
      ''');
    });
  }

  // 向表里插入数据
  Future<User> insert(User user) async {
    user.id = await db!.insert(tableName, user.toMap());
    return user;
  }

  // 查询表里对于username字段的记录
  Future<User> getUserByUsername(String username) async {
    List<Map<String, dynamic>> maps = await db!.query(tableName,
        columns: [columnId, columnPassword, columnUsername, columnNickname],
        where: '$columnUsername = ?',
        whereArgs: [username]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return User();
  }

  // 删除表里对于id字段的记录
  Future<int> delete(int id) async {
    return await db!.delete(tableName, where: '$columnId=?', whereArgs: [id]);
  }

  // 修改表里的某条记录
  Future<int> update(User user) async {
    return await db!.update(tableName, user.toMap(),
        where: '$columnId=>', whereArgs: [user.id]);
  }

  //关闭数据库
  Future close() async => db!.close();
}
