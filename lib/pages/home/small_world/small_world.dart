import 'package:flutter/material.dart';
import '../../../../utils/user.dart';

class SmallWorld extends StatelessWidget {
  final User? myAccount;

  const SmallWorld(this.myAccount, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("small_world"));
  }
}
