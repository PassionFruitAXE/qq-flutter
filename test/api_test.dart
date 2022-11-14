import 'package:flutter_test/flutter_test.dart';
import 'package:qq_for_flutter/api/generalNews.dart';
import 'package:qq_for_flutter/model/new.dart';

void main() {
  test("getGeneralNews test", () async {
    var response = await getGeneralNews();
    List<dynamic> temp = response!['newslist'];
    List<New> news = temp.map((item) => New.fromMap(item)).toList();
    for (var item in news) {
      expect(item, isNotNull);
    }
  });
}
