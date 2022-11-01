import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class NetworkImageSSL extends ImageProvider<NetworkImageSSL> {
  const NetworkImageSSL(this.url, {this.scale = 1.0, required this.headers});

  final String url;

  final double scale;

  final Map<String, String> headers;

  @override
  Future<NetworkImageSSL> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageSSL>(this);
  }

  @override
  ImageStreamCompleter load(NetworkImageSSL key, decode) {
    return MultiFrameImageStreamCompleter(
        codec: _loadAsync(key), scale: key.scale);
  }

  static final HttpClient _httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

  Future<ui.Codec> _loadAsync(NetworkImageSSL key) async {
    assert(key == this);

    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    headers.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(
          'HTTP request failed, statusCode: ${response.statusCode}, $resolved');
    }

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0) {
      throw Exception('NetworkImageSSL is an empty file: $resolved');
    }

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final NetworkImageSSL typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => Object.hash(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
