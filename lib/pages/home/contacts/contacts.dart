import 'package:flutter/material.dart';
import '../../../../utils/user.dart';

class Contacts extends StatefulWidget {
  final User? myAccount;

  const Contacts(this.myAccount, {super.key});

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("contacts"));
  }
}
