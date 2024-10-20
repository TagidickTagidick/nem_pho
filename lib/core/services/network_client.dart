import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/core/utils/custom_log.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../models/error_model.dart';

abstract class INetworkClient {
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> delete(String url);
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body);
  Future<void> refresh();
}

class NetworkClient extends INetworkClient {
  static final NetworkClient _singleton = NetworkClient._internal();

  factory NetworkClient() {
    return _singleton;
  }

  NetworkClient._internal();

  final Talker talker = Talker();
  final IStorageService _storageService = StorageService();
  final Dio dio = Dio();

  String getPrettyJSONString(Map<String, dynamic> jsonObject) {
    const encoder = JsonEncoder.withIndent('\t');
    return encoder.convert(jsonObject);
  }

  Future<void> init() async {
    final accessToken = await _storageService.getAccessToken();
    dio.options = BaseOptions(
      baseUrl: 'https://nem-pho-backend.onrender.com/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
    );
  }

  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    try {
      logRequest('post', url, body: body);
      Response response = await dio.post(
        url,
        data: body,
      );
      logResponse(response.statusCode!, response.data, 'post', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          await refresh();
          logRequest('post', url);
          Response response = await dio.post(
            url,
            data: body,
          );
          logResponse(response.statusCode!, response.data, 'post', url);
          switch (response.statusCode) {
            case 200:
              return response.data;
            default:
              throw ErrorModel(
                  statusCode: response.statusCode!,
                  message: response.data
              );
          }
        default:
          return {
            'success': false,
            'status_code': response.statusCode
          };
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      logRequest('get', url);
      Response response = await dio.get(
        url,
      );
      logResponse(response.statusCode!, response.data, 'get', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          await refresh();
          logRequest('get', url);
          Response response = await dio.get(
            url,
          );
          logResponse(response.statusCode!, response.data, 'get', url);
          switch (response.statusCode) {
            case 200:
              return response.data;
            default:
              throw ErrorModel(
                  statusCode: response.statusCode!,
                  message: response.data
              );
          }
        default:
          throw ErrorModel(
              statusCode: response.statusCode!,
              message: response.data
          );
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> delete(String url) async {
    try {
      logRequest('delete', url);
      Response response = await dio.delete(
        url,
      );
      logResponse(response.statusCode!, response.data, 'delete', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          await refresh();
          logRequest('delete', url);
          Response response = await dio.delete(
            url,
          );
          logResponse(response.statusCode!, response.data, 'delete', url);
          switch (response.statusCode) {
            case 200:
              return response.data;
            default:
              throw ErrorModel(
                  statusCode: response.statusCode!,
                  message: response.data
              );
          }
        default:
          throw ErrorModel(
              statusCode: response.statusCode!,
              message: response.data
          );
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body) async {
    try {
      logRequest('patch', url, body: body);
      Response response = await dio.patch(
        url,
      );
      logResponse(response.statusCode!, response.data, 'patch', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          await refresh();
          logRequest('patch', url);
          Response response = await dio.patch(
            url,
          );
          logResponse(response.statusCode!, response.data, 'patch', url);
          switch (response.statusCode) {
            case 200:
              return response.data;
            default:
              throw ErrorModel(
                  statusCode: response.statusCode!,
                  message: response.data
              );
          }
        default:
          throw ErrorModel(
              statusCode: response.statusCode!,
              message: response.data
          );
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> refresh() async {
    try {
      logRequest('post', 'refresh');
      Response response = await dio.post(
          'refresh',
      );
      logResponse(response.statusCode!, response.data, 'post', 'refresh');
      if (response.statusCode == 200) {
        await _storageService.setToken(
          response.data['payload']['access_token'],
          response.data['payload']['refresh_token'],
        );
      } else {
        throw ErrorModel(
            statusCode: response.statusCode!,
            message: response.data
        );
      }
    } catch (_) {
      rethrow;
    }
  }

  void logRequest(
      String type,
      String url,
      {Map<String, dynamic>? body}
      ){
    talker.logTyped(CustomLog(
        '\nType: $type'
        '\nurl: ${dio.options.baseUrl}$url'
        '${body == null ? '' : '\nbody: $body'}',
        'REQUEST',
        015
    ));
  }

  void logResponse(
      int statusCode,
      Map<String, dynamic> body,
      String type,
      String url
      ) {
    talker.logTyped(CustomLog(
        '\nType: $type'
            '\nurl: ${dio.options.baseUrl}$url'
            '\nStatus: $statusCode'
            '\nBody: ${getPrettyJSONString(body)}',
        'RESPONSE',
        statusCode == 200 ? 046 : 009
    ));
  }
}