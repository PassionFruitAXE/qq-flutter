import 'package:flutter/material.dart';

import '../pages/home/message/dialog/dialog.dart';
import '../utils/user.dart';
import '../utils/chat_data.dart';

class DiaLogList extends StatefulWidget {
  final User? myAccount;
  const DiaLogList(this.myAccount, {super.key});

  @override
  DiaLogListState createState() => DiaLogListState();
}

class DiaLogListState extends State<DiaLogList> {
  final List<ChatData> chatData = [
    ChatData("1", ["test"], "images/avatar.jpg"),
    ChatData("2", ["test"], "images/avatar.jpg"),
    ChatData("3", ["test"], "images/avatar.jpg"),
    ChatData("4", ["test"], "images/avatar.jpg"),
    ChatData("5", ["test"], "images/avatar.jpg"),
    ChatData("6", ["test"], "images/avatar.jpg"),
    ChatData("7", ["test"], "images/avatar.jpg"),
    ChatData("8", ["test"], "images/avatar.jpg"),
    ChatData("9", ["test"], "images/avatar.jpg"),
    ChatData("10", ["test"], "images/avatar.jpg"),
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
                  trailing: Text(
                      '${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}'),
                  isThreeLine: false,
                  dense: false,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyDialog(data, (String newMessage) {
                            setState(() {
                              chatData[index].messages = [
                                newMessage,
                                ...chatData[index].messages
                              ];
                            });
                          });
                        },
                      ),
                    );
                  },
                  onLongPress: () {});
            }));
  }
}
