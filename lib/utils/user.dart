class User {
  final String? _username;
  final String? _password;
  final String? _nickname;
  User(this._username, this._password, this._nickname);

  get getUsername => _username;
  get getPassword => _password;
  get getNickname => _nickname;

  Map<String, String> getAccount() {
    return {
      'username': getUsername,
      'password': getPassword,
    };
  }
}

User myAccount = User('12345678', '87654321', 'PassionFruit');
