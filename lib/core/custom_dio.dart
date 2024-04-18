import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:pantest/lib.dart';

class CustomDio with DioMixin implements Dio {
  CustomDio._() {
    options = BaseOptions(
      contentType: 'application/json; charset=utf-8',
      connectTimeout: const Duration(
        seconds: 50000,
      ),
      receiveTimeout: const Duration(
        seconds: 30000,
      ),
    );

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (Platform.isAndroid || Platform.isIOS) {
            final uaData = await userAgentData();
            options.headers.addAll(
              {
                'User-Agent':
                    '${uaData.package.appName} (${uaData.platform} ${uaData.platformVersion}; ${uaData.model}; ${uaData.device}; ${uaData.architecture};)',
                'app-id': '661e5d8d0cdec13eaa70ca62'
              },
            );
          }
          handler.next(options);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (error, handler) async {
          handler.next(error);
        },
      ),
    );
    if (kDebugMode) {
      interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (object) => log(object.toString()),
        ),
      );
    }
    httpClientAdapter = IOHttpClientAdapter();
  }

  static final CustomDio _instance = CustomDio._();

  static CustomDio get instance => _instance;
}
