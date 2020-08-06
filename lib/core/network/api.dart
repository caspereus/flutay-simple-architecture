import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amar_bank_test/core/network/network_constant.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

enum RequestMethod { POST, GET }

class Api {
  static const int _timeoutDuration = 30000;
  static const int maxCallApi = 3;
  Dio _dio;
  StreamController<DioError> _dioResponseStreamController;
  bool isShowNoConnectionAlert = true;

  BehaviorSubject<DioError> get dioResponseStream =>
      _dioResponseStreamController.stream;

  Api() {
    _dioResponseStreamController = BehaviorSubject<DioError>();
    _dio = Dio();
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          request: true, requestBody: true, responseBody: true, error: true));
    }
  }

  void resetDioError() {
    _dioResponseStreamController.add(null);
  }

  Future<dynamic> get({String url, Map<String, dynamic> header}) async {
    BaseOptions baseOptions = new BaseOptions();
    Map<String, dynamic> headerJson = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (header != null) headerJson.addAll(header);
    baseOptions.connectTimeout = _timeoutDuration;
    baseOptions.receiveTimeout = _timeoutDuration;
    baseOptions.headers = headerJson;
    _dio.options = baseOptions;

    Response<dynamic> responseApi;

    if (kDebugMode || kProfileMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      };
    }

    for (int i = 1; i <= maxCallApi; i++) {
      try {
        responseApi = await _dio.get(NetworkConstant.BASE_URL + url);
        _dioResponseStreamController.add(null);
        return jsonEncode(responseApi.data);
      } on DioError catch (dioError) {
        responseApi = dioError.response;
        if (i == maxCallApi) {
          print("Call Api Number $i MaxCallApi $maxCallApi");
          _dioResponseStreamController.add(dioError);
        }
        if (i < maxCallApi) continue;
        throw Exception;
      }
    }
  }

  Future<dynamic> post(
      {String url, dynamic body, Map<String, dynamic> header}) async {
    BaseOptions baseOptions = new BaseOptions();
    Map<String, dynamic> headerJson = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (header != null) headerJson.addAll(header);
    baseOptions.connectTimeout = _timeoutDuration;
    baseOptions.receiveTimeout = _timeoutDuration;
    baseOptions.headers = headerJson;
    _dio.options = baseOptions;

    Response<dynamic> responseApi;

    if (kDebugMode || kProfileMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      };
    }

    for (int i = 1; i <= maxCallApi; i++) {
      try {
        responseApi =
            await _dio.post(NetworkConstant.BASE_URL + url, data: body);
        _dioResponseStreamController.add(null);
        return jsonEncode(responseApi.data);
      } on DioError catch (dioError) {
        responseApi = dioError.response;
        if (i == maxCallApi) _dioResponseStreamController.add(dioError);
        if (i < maxCallApi) continue;
        print("ResponseHTTP :  ${jsonDecode(responseApi.data)}");
        throw Exception;
      }
    }
  }
}

class ResponseCode {
  static const SUCCESS = 200;
  static const UNAUTHORIZED = 401;
  static const NOT_FOUND = 404;
}
