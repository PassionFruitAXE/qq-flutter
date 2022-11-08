import 'package:flutter/material.dart';
import '../../../vendor/sqflite/database.dart';
import '../login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  final TextEditingController _nicknameController =
      TextEditingController(text: "");

  // 密码是否可见
  bool _isVisible = false;

  // 是否正确填写用户名密码
  bool _isFinish = false;

  // 获取用户输入信息
  Map<String, String> getUserInput() {
    return {
      'nickname': _nicknameController.text,
      'username': _usernameController.text,
      'password': _passwordController.text
    };
  }

  // 输入验证
  void formLint(String string) {
    Map<String, String> userInput = getUserInput();
    RegExp nicknameRegExp = RegExp(r"[0-9a-zA-Z]{0,10}$");
    RegExp usernameRegExp = RegExp(r"[0-9a-zA-Z]{0,12}$");
    RegExp passwordRegExp =
        RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$");
    if (nicknameRegExp.hasMatch(userInput['nickname']!) &&
        usernameRegExp.hasMatch(userInput['username']!) &&
        passwordRegExp.hasMatch(userInput['password']!)) {
      setState(() {
        _isFinish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "注册账号",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("注册账号"),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            body: Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Image(
                          image: AssetImage('images/QQ.png'), width: 120.0),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  controller: _nicknameController,
                                  onChanged: formLint,
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00FF0000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00000000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(25),
                                    prefixIcon: Icon(Icons.lock),
                                    // fillColor: Colors.blue,
                                    hintText: "用户名(最高10位)",
                                  ),
                                ),
                                TextField(
                                  controller: _usernameController,
                                  onChanged: formLint,
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00FF0000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00000000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(25),
                                    prefixIcon: Icon(Icons.lock),
                                    // fillColor: Colors.blue,
                                    hintText: "QQ号(8-12位)",
                                  ),
                                ),
                                TextField(
                                  controller: _passwordController,
                                  onChanged: formLint,
                                  obscureText: !_isVisible,
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 16,
                                  decoration: InputDecoration(
                                    filled: true,
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00FF0000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0x00000000)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(25),
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                          Icons.remove_red_eye_outlined),
                                      onPressed: () {
                                        setState(() {
                                          _isVisible = !_isVisible;
                                        });
                                      },
                                    ),
                                    hintText: "密码(8-16位数字+大小写字母)",
                                  ),
                                ),
                              ])),
                      MaterialButton(
                          onPressed: () async {
                            if (!_isFinish) {
                              return;
                            }
                            Map<String, String> userInput = getUserInput();
                            // 注册到数据库 成功后弹窗提示

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Login(
                                      cacheUser: User(
                                          username: userInput['username']!,
                                          password: userInput['password']!,
                                          nickname: userInput['nickname']!));
                                },
                              ),
                            );
                          },
                          color: _isFinish
                              ? Colors.blue
                              : const Color.fromARGB(255, 115, 184, 240),
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: _isFinish
                                      ? Colors.blue
                                      : const Color.fromARGB(
                                          255, 115, 184, 240))),
                          height: 100,
                          child: const Text('注册',
                              style: TextStyle(color: Colors.white))),
                    ]))));
  }
}
