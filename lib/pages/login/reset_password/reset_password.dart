import 'package:flutter/material.dart';
import 'package:qq_for_flutter/vendor/fluttertoast/global_message.dart';
import 'package:qq_for_flutter/vendor/sqflite/controllers/account_controller.dart';
import '../../../vendor/sqflite/domain/user.dart';
import '../login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _usernameController =
      TextEditingController(text: "L86441933");
  final TextEditingController _oldPasswordController =
      TextEditingController(text: "Lw123456");
  final TextEditingController _newPasswordController =
      TextEditingController(text: "Lw123456");

  // 密码是否可见
  bool _isVisible = false;

  // 是否正确填写用户名密码
  bool _isFinish = false;

  // 获取用户输入信息
  Map<String, String> getUserInput() {
    return {
      'username': _usernameController.text,
      'oldPassword': _oldPasswordController.text,
      'newPassword': _newPasswordController.text
    };
  }

  // 输入验证
  void formLint(String string) {
    Map<String, String> userInput = getUserInput();
    RegExp usernameRegExp = RegExp(r"[0-9a-zA-Z]{0,12}$");
    RegExp passwordRegExp =
        RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$");
    if (usernameRegExp.hasMatch(userInput['username']!) &&
        passwordRegExp.hasMatch(userInput['oldPassword']!)) {
      setState(() {
        _isFinish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    formLint("");
    return MaterialApp(
        title: "修改密码",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("修改密码"),
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
                                    hintText: "要修改的QQ号",
                                  ),
                                ),
                                TextField(
                                  controller: _oldPasswordController,
                                  onChanged: formLint,
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 16,
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
                                    prefixIcon:
                                        Icon(Icons.remove_red_eye_outlined),
                                    // fillColor: Colors.blue,
                                    hintText: "旧密码",
                                  ),
                                ),
                                TextField(
                                  controller: _newPasswordController,
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
                                    hintText: "新密码(8-16位数字+大小写字母)",
                                  ),
                                ),
                              ])),
                      MaterialButton(
                          onPressed: () async {
                            if (!_isFinish) {
                              return;
                            }
                            // 从数据库拿到用户
                            User user = await AccountController.getAccount(
                                _usernameController.text);
                            Map<String, String> userInput = getUserInput();
                            if (userInput['username'] == user.getUsername &&
                                userInput['oldPassword'] == user.getPassword) {
                              user.setPassword = userInput['newPassword']!;
                              // 验证成功 修改密码
                              AccountController.updateAccount(user)
                                  .then((count) async {
                                if (count != 0) {
                                  GlobalMessage.success("修改成功");
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return Login(cacheUser: user);
                                      },
                                    ),
                                  );
                                } else {
                                  GlobalMessage.error("修改失败");
                                }
                              }).catchError((err) {
                                GlobalMessage.error(err.toString());
                              });
                            }else {
                              GlobalMessage.error("旧密码错误，请重试");
                            }
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
                          child: const Text('修改密码',
                              style: TextStyle(color: Colors.white))),
                    ]))));
  }
}
