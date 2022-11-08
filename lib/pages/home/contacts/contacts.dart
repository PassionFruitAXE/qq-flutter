import 'package:flutter/material.dart';
import '../../../vendor/sqflite/database.dart';

class Contacts extends StatefulWidget {
  final User? myAccount;

  const Contacts( {super.key, required this.myAccount});

  @override
  ContactsState createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("contacts"));
  }
}
