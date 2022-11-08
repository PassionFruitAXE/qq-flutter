import 'package:flutter/material.dart';
import '../../../../model/user.dart';
import '../../../components/personal_list.dart';

class Personal extends StatelessWidget {
  final User? myAccount;

  const Personal({super.key, required this.myAccount});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "个人中心",
        home: Scaffold(
          appBar: AppBar(
              title: const Text("个人中心"),
              leading: IconButton(
                  icon: Container(
                      padding: const EdgeInsets.all(3.0),
                      width: 100,
                      height: 100,
                      child: const Icon(Icons.arrow_back)),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          body: PersonalList(),
        ));
  }
}
