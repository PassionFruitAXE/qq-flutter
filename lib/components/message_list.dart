import 'package:flutter/material.dart';

import '../utils/chat_data.dart';

class PersonalList extends StatelessWidget {
  final ChatData chatData;

  const PersonalList({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chatData.messages.length,
            itemBuilder: (_, index) {
              return Card(
                  color: Colors.grey[250],
                  elevation: 5.0,
                  margin: const EdgeInsets.all(10),
                  child: Builder(
                      builder: (context) => InkWell(
                          onTap: () {},
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(chatData.messages[index],
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold))
                                  ])))));
            }));
  }
}
