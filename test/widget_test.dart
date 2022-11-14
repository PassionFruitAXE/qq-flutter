// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qq_for_flutter/main.dart';
import 'package:qq_for_flutter/pages/home/home.dart';
import 'package:qq_for_flutter/pages/login/login.dart';
import 'package:qq_for_flutter/vendor/sqflite/domain/user.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QQApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  testWidgets("Account transmit test", (WidgetTester tester) async {
    await tester.pumpWidget(Home(
      myAccount: User(
          username: 'LuoWei',
          password: 'Lw123456',
          nickname: 'PassionFruit',
          avatarURL: "images/头像2.jpg"),
    ));
    final nicknameFinder = find.text('PassionFruit');
    expect(nicknameFinder, findsOneWidget);
  });
  testWidgets("Login input test", (WidgetTester tester) async {
    const usernameKey = Key('usernameKey');
    const passwordKey = Key("passwordKey");
    const loginButtonKey = Key("loginButtonKey");
    await tester.pumpWidget(const Login());
    await tester.enterText(find.byKey(usernameKey), 'L86441933');
    await tester.enterText(find.byKey(passwordKey), 'Lw123456');
    expect(find.text('L86441933'), findsOneWidget);
    expect(find.text('Lw123456'), findsOneWidget);
    await tester.tap(find.byKey(loginButtonKey));
    await tester.pump();
    expect(find.text('L86441933'), findsNothing);
    expect(find.text('Lw123456'), findsNothing);
  });
}
