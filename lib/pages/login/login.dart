import 'package:flutter/material.dart';
import '../home/home.dart';
import '../../../utils/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // 密码是否可见
  bool _isVisible = false;
  // 是否勾选checkbox
  bool _checkboxSelected = false;

  // 获取用户输入信息
  Map<String, String> getUserInput() {
    return {
      'username': _usernameController.text,
      'password': _passwordController.text
    };
  }

  // 登录检测
  bool login() {
    Map<String, String> userInput = getUserInput();
    Map<String, String> rightAccount = myAccount.getAccount();
    return userInput['username'] == rightAccount['username'] &&
        userInput['password'] == rightAccount['password'];
  }

  // 清空输入框123
  void clearInput() {
    setState(() {
      _usernameController.text = '';
      _passwordController.text = '';
      _checkboxSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const Image(image: AssetImage('images/QQ.jpg')),
      TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          icon: Icon(Icons.text_fields),
          labelText: '请输入你的QQ号',
          helperText: '全数字的QQ号码',
        ),
        textAlign: TextAlign.start,
        autofocus: true,
        controller: _usernameController,
      ),
      TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            icon: const Icon(Icons.text_fields),
            labelText: '请输入你的密码',
            suffixIcon: IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
            )),
        textAlign: TextAlign.start,
        autofocus: true,
        controller: _passwordController,
        obscureText: !_isVisible,
      ),
      Row(children: [
        Checkbox(
            value: _checkboxSelected,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            }),
        const Text('已阅读并同意服务协议和QQ隐私保护指引')
      ]),
      MaterialButton(
          onPressed: () async {
            if (!_checkboxSelected) {
              return;
            }
            if (login()) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Home(myAccount);
                  },
                ),
              );
            } else {
              clearInput();
            }
          },
          color: _checkboxSelected
              ? Colors.blue
              : const Color.fromARGB(255, 115, 184, 240),
          shape: CircleBorder(
              side: BorderSide(
                  color: _checkboxSelected
                      ? Colors.blue
                      : const Color.fromARGB(255, 115, 184, 240))),
          height: 100,
          child: const Text('登录', style: TextStyle(color: Colors.white))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
        Text('手机号登录'),
        Text('新用户注册'),
        Text('更多选项'),
      ])
    ]);
  }
}
