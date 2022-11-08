class User {
  String? _username;
  String? _password;
  String? _nickname;

  User({username, password, nickname}) {
    _username = username;
    _password = password;
    _nickname = nickname;
  }

  get getUsername => _username;

  get getPassword => _password;

  get getNickname => _nickname;
}

User myAccount =
    User(username: 'l86441933', password: 'Lw123456', nickname: 'PassionFruit');
