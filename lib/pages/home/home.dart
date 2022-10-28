import 'package:flutter/material.dart';
import 'message/message.dart';
import 'small_world/small_world.dart';
import 'contacts/contacts.dart';
import 'status/status.dart';
import '../../../utils/user.dart';

class Home extends StatefulWidget {
  final User? myAccount;

  const Home(this.myAccount, {super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  // 底部导航栏
  List<BottomNavigationBarItem> bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: '消息',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: '联系人',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.adjust),
      label: '小世界',
      backgroundColor: Colors.blue,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.refresh),
      label: '动态',
      backgroundColor: Colors.blue,
    ),
  ];

  // 当前页下标
  int currentIndex = 0;
  //
  final pages = [
    Message(myAccount),
    SmallWorld(myAccount),
    Contacts(myAccount),
    Status(myAccount)
  ];

  // 修改当前页
  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QQ",
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.shifting,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex],
      ),
    );
  }
}
