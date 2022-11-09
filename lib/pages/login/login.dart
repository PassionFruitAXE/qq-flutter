import 'package:flutter/material.dart';
import 'package:qq_for_flutter/pages/login/register/register.dart';
import 'package:qq_for_flutter/pages/login/reset_password/reset_password.dart';
import 'package:qq_for_flutter/vendor/shared_preferences/storage.dart';
import '../../vendor/sqflite/controllers/account_controller.dart';
import '../home/home.dart';
import '../../vendor/fluttertoast/global_message.dart';
import '../../vendor/sqflite/domain/user.dart';

class Login extends StatefulWidget {
  final User? cacheUser;

  const Login({super.key, this.cacheUser});

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

  @override
  initState() {
    // 初始化时有注册传过来的账号直接读 没有则从缓存中读取
    super.initState();
    if (widget.cacheUser != null) {
      _usernameController.text = widget.cacheUser?.getUsername;
      _passwordController.text = widget.cacheUser?.getPassword;
    } else {
      () async {
        User? cacheAccount = await getCacheAccount();
        if (cacheAccount != null) {
          _usernameController.text = cacheAccount.getUsername;
          _passwordController.text = cacheAccount.getPassword;
        }
      }();
    }
  }

  // 获取用户输入信息
  Map<String, String> getUserInput() {
    return {
      'username': _usernameController.text,
      'password': _passwordController.text
    };
  }

  // 登录账号验证
  bool accountJudge(User account) {
    Map<String, String> userInput = getUserInput();
    return userInput['username'] == account.getUsername &&
        userInput['password'] == account.getPassword;
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
    return MaterialApp(
        title: "注册账号",
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Image(image: AssetImage('images/QQ.png'), width: 120.0),
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
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
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
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500))
                      ])),
                  MaterialButton(
                      onPressed: () async {
                        if (!_checkboxSelected) {
                          GlobalMessage.info("请勾选已已阅读服务协议");
                          return;
                        }
                        // 根据username从数据库读取账号信息
                        AccountController.getAccount(_usernameController.text)
                            .then((account) async {
                          if (accountJudge(account)) {
                            // 登录成功后 缓存账号信息
                            GlobalMessage.success("登录成功");
                            setCacheAccount(account);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  // 账号信息放在内存中 组件间传递
                                  return Home(myAccount: account);
                                },
                              ),
                            );
                          } else {
                            GlobalMessage.error("账号或密码错误，请重试");
                            removeCacheAccount();
                            clearInput();
                          }
                        });
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
                      child: const Text('登录',
                          style: TextStyle(color: Colors.white))),
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                onPressed: () {},
                                child: const Text("手机登录",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500))),
                            MaterialButton(
                                onPressed: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ResetPassword();
                                  }));
                                },
                                child: const Text("修改密码",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500))),
                            MaterialButton(
                                onPressed: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Register();
                                  }));
                                },
                                child: const Text("注册账号",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500))),

                            // Text('新用户注册', style: TextStyle(fontWeight: FontWeight.w500)),
                          ]))
                ])));
  }
}
