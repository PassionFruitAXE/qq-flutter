import 'package:flutter/material.dart';

class PersonalList extends StatelessWidget {
  final List<String> messages;
  const PersonalList(this.messages, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (_, index) {
              return ListTile(
                  title: Text(messages[index]),
                  isThreeLine: false,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  onTap: () {},
                  onLongPress: () {});
            }));
  }
}
