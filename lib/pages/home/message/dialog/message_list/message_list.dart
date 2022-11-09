import 'package:flutter/material.dart';

import '../../../../../model/chat_data.dart';

class MessageList extends StatelessWidget {
  final ChatData chatData;

  const MessageList({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chatData.messages.length,
            itemBuilder: (_, index) =>
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextField(
                      readOnly: true,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
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
                        contentPadding: const EdgeInsets.all(15),
                        hintText: chatData.messages[index],
                      ),
                    ))
        ));
  }
}
