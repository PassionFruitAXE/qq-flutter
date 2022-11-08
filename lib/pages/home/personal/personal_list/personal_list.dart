import 'package:flutter/material.dart';

class PersonalList extends StatelessWidget {
  PersonalList({super.key});

  final List<String> list = [
    "直播",
    "会员",
    "钱包",
    "个性装扮",
    "收藏",
    "相册",
    "文件",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return ListTile(
                  title: Text(list[index]),
                  isThreeLine: false,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  enabled: true,
                  onTap: () async {
                    // await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       print("跳转")
                    //     },
                    //   ),
                    // );
                  },
                  onLongPress: () {});
            }));
  }
}
