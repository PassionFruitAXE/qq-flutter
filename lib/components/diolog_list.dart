import 'package:flutter/material.dart';

import '../pages/home/message/dialog/dialog.dart';
import '../utils/user.dart';
import '../utils/chat_data.dart';

class DiaLogList extends StatefulWidget {
  final User? myAccount;

  const DiaLogList({super.key, required this.myAccount});

  @override
  DiaLogListState createState() => DiaLogListState();
}

class DiaLogListState extends State<DiaLogList> {
  final List<ChatData> chatData = [
    ChatData("初级程序员", ["test"], "images/头像1.jpg", ""),
    ChatData("资深程序员", ["test"], "images/头像3.jpg", ""),
    ChatData("高级资深程序员", ["test"], "images/头像4.jpg", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chatData.length,
            itemBuilder: (_, index) {
              var data = chatData[index];
              return ListTile(
                  leading: CircleAvatar(
                    radius: 40.0,
                    child: Image.asset(data.imgUrl),
                  ),
                  title: Text(data.name),
                  subtitle: Text(data.messages[0]),
                  trailing: Text(chatData[index].lastTime),
                  isThreeLine: false,
                  dense: false,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyDialog(data, (String newMessage) {
                        setState(() {
                          chatData[index].messages = [
                            newMessage,
                            ...chatData[index].messages
                          ];
                          chatData[index].lastTime =
                              '${DateTime.now().hour.toString()}:${DateTime.now().minute < 10 ? "0${DateTime.now().minute.toString()}" : DateTime.now().minute.toString()}';
                        });
                      });
                    }));
                  },
                  onLongPress: () {});
            }));
  }
}
