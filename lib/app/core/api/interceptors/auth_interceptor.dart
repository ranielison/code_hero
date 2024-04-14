import 'dart:convert';

import 'package:code_hero/app/core/config/config.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final publicKey = Config.publicKey;
    final privateKey = Config.privateKey;

    final hash = md5.convert(utf8.encode('$timestamp$privateKey$publicKey'));

    options.queryParameters['ts'] = timestamp;
    options.queryParameters['apikey'] = publicKey;
    options.queryParameters['hash'] = hash;

    handler.next(options);
  }
}
