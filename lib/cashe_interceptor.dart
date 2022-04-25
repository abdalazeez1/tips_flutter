import 'dart:developer';

import 'package:dio/dio.dart';

class CacheInterceptor extends QueuedInterceptor {
  // CacheInterceptor({required StorageService storageService}):_storageService=storageService;
  // final StorageService _storageService;
  final _cache = <Uri, Response>{};

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Do something before request is sent
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Do something with response data
    await Future.delayed(const Duration(milliseconds: 300));
    //you can save [_cache] to any locale storage [_storageService]
    _cache[response.requestOptions.uri] = response;
    return handler.next(response);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout ||
        err.type == DioErrorType.other) {
      //get cash from local storage[_storageService]
      await Future.delayed(const Duration(milliseconds: 300));
      var cachedResponse = _cache[err.requestOptions.uri];
      if (cachedResponse != null) {
        return handler.resolve(cachedResponse);
      }
    }
    return handler.next(err);
  }
}
