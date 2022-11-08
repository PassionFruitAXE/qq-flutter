import 'package:flutter/material.dart';
import '../../../../components/message_list.dart';
import '../../../../model/chat_data.dart';

class MyDialog extends StatefulWidget {
  final ChatData chatData;
  final Function addMessage;

  const MyDialog(
    this.chatData,
    this.addMessage, {
    super.key,
  });

  @override
  MyDialogState createState() => MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  final TextEditingController _inputController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.chatData.name,
        home: Scaffold(
            appBar: AppBar(
                title: Text(widget.chatData.name),
                leading: IconButton(
                    icon: Container(
                        padding: const EdgeInsets.all(3.0),
                        width: 100,
                        height: 100,
                        child: const Icon(Icons.arrow_back)),
                    onPressed: () {
                      Navigator.pop(context);
                    })),
            bottomSheet: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  labelText: '请输入你要发送的信息',
                  suffixIcon: IconButton(
                    icon: _isVisible ? const Icon(Icons.send) : Container(),
                    onPressed: () {
                      setState(() {
                        widget.addMessage(_inputController.text);
                      });
                    },
                  )),
              onChanged: (value) {
                setState(() {
                  _isVisible = value.isNotEmpty;
                });
              },
              textAlign: TextAlign.start,
              controller: _inputController,
            ),
            body: PersonalList(chatData: widget.chatData)));
  }
}
