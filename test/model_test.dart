import 'package:flutter_test/flutter_test.dart';
import 'package:qq_for_flutter/model/new.dart';
import 'package:qq_for_flutter/vendor/sqflite/domain/user.dart';

void main() {
  group("class Test", () {
    test("toMap test", () {
      Map<String, dynamic> data = {
        'id': null,
        'username': null,
        'password': null,
        'nickname': null,
        'avatarURL': null,
      };
      Map<String, dynamic> user = User().toMap();
      expect(user['id'], data['id']);
      expect(user['username'], data['username']);
      expect(user['password'], data['password']);
      expect(user['nickname'], data['nickname']);
      expect(user['avatarURL'], data['avatarURL']);
    });

    test("fromMap test", () {
      User data = User.fromMap({
        'id': null,
        'username': null,
        'password': null,
        'nickname': null,
        'avatarURL': null,
      });
      User user = User();
      expect(user.id, data.id);
      expect(user.getUsername, data.getUsername);
      expect(user.getPassword, data.getPassword);
      expect(user.getNickname, data.getNickname);
      expect(user.getAvatarUrl, data.getAvatarUrl);
    });

    test("toMap test", () {
      Map<String, dynamic> data = {
        "id": null,
        "ctime": null,
        "title": null,
        "description": null,
        "source": null,
        "picUrl": null,
        "url": null,
      };
      Map<String, dynamic> temp = New().toMap();
      expect(temp['id'], data['id']);
      expect(temp['ctime'], data['ctime']);
      expect(temp['title'], data['title']);
      expect(temp['description'], data['description']);
      expect(temp['source'], data['source']);
      expect(temp['picUrl'], data['picUrl']);
      expect(temp['url'], data['url']);
    });

    test("fromMap test", () {
      New data = New();
      New temp = New.fromMap({
        "id": null,
        "ctime": null,
        "title": null,
        "description": null,
        "source": null,
        "picUrl": null,
        "url": null,
      });
      expect(temp.id, data.id);
      expect(temp.ctime, data.ctime);
      expect(temp.title, data.title);
      expect(temp.description, data.description);
      expect(temp.source, data.source);
      expect(temp.picUrl, data.picUrl);
      expect(temp.url, data.url);
    });
  });
}
