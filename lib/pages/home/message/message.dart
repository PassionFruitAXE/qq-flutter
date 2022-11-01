import 'package:flutter/material.dart';

import '../../../components/diolog_list.dart';
import '../../../../utils/user.dart';
import '../personal/personal.dart';

class Message extends StatelessWidget {
  final User? myAccount;

  const Message({super.key, required this.myAccount});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QQ',
      home: Scaffold(
          appBar: AppBar(
              title: Text(myAccount?.getNickname),
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(3.0),
                  width: 100,
                  height: 100,
                  child: const CircleAvatar(
                      backgroundImage: AssetImage('images/头像2.jpg')),
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Personal(myAccount: myAccount);
                      },
                    ),
                  );
                },
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.account_circle), onPressed: () {}),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        value: 1, onTap: () {}, child: const Text('创建群聊')),
                    PopupMenuItem(
                        value: 2, onTap: () {}, child: const Text('加好友/群'))
                  ],
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: const Icon(Icons.add),
                  ),
                ),
              ]),
          body: DiaLogList(myAccount: myAccount)),
    );
  }
}
