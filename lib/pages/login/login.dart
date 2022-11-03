import 'package:flutter/material.dart';
import '../home/home.dart';
import '../../../utils/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController =
      TextEditingController(text: "12345678");
  final TextEditingController _passwordController =
      TextEditingController(text: "87654321");

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
  bool accountJudge() {
    Map<String, String> userInput = getUserInput();
    Map<String, String> rightAccount = myAccount.getAccount();
    return userInput['username'] == rightAccount['username'] &&
        userInput['password'] == rightAccount['password'];
  }

  // 清空输入框
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
      const Image(image: AssetImage('images/QQ.jpg'), width: 120.0),
      Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00FF0000)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00000000)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(25),
                    prefixIcon: Icon(Icons.lock),
                    // fillColor: Colors.blue,
                    hintText: "请输入QQ号",
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isVisible,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.done,
                  maxLength: 16,
                  decoration: InputDecoration(
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00FF0000)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0x00000000)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(25),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                    ),
                    hintText: "请输入密码",
                  ),
                ),
              ])),
      Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(children: [
            Checkbox(
                value: _checkboxSelected,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value!;
                  });
                }),
            const Text('已阅读并同意服务协议和QQ隐私保护指引',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w500))
          ])),
      MaterialButton(
          onPressed: () async {
            if (!_checkboxSelected) {
              return;
            }
            if (accountJudge()) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Home(myAccount: myAccount);
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
      Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('手机号登录', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('新用户注册', style: TextStyle(fontWeight: FontWeight.w500)),
                Text('更多选项', style: TextStyle(fontWeight: FontWeight.w500)),
              ]))
    ]);
  }
}
