import 'dart:convert';

import 'package:dio/dio.dart';

Future<Map<String, dynamic>?> getHotReviews() async {
  try {
    String key = '0c3aa7139579951aaa2bac8636748a1d';
    var response = await Dio().get('http://api.tianapi.com/weibohot/index',
        options: Options(responseType: ResponseType.bytes),
        queryParameters: {"key": key});
    return json.decode(const Utf8Decoder().convert(response.data));
  } catch (e) {
    print(e);
  }
  return null;
}
