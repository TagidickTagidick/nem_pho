import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/core/utils/custom_log.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:nem_pho/core/models/error_model.dart';

abstract class INetworkClient {
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> delete(String url);
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body);
  Future<void> init();
  Future<void> refresh();
}

class NetworkClient extends INetworkClient {
  static final NetworkClient _singleton = NetworkClient._internal();

  factory NetworkClient() {
    return _singleton;
  }

  NetworkClient._internal();

  final Talker talker = Talker();
  final IStorageService _storageService = StorageService(
      storage: const FlutterSecureStorage(
          aOptions: AndroidOptions(
              encryptedSharedPreferences: true
          )
      )
  );
  final Dio dio = Dio();

  String _getPrettyJSONString(Map<String, dynamic> jsonObject) {
    const encoder = JsonEncoder.withIndent('\t');
    return encoder.convert(jsonObject);
  }

  @override
  Future<void> init() async {
    final accessToken = await _storageService.getAccessToken();
    dio.options = BaseOptions(
      baseUrl: 'https://nikolyamba-nem-pho-backend-64d9.twc1.net/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      validateStatus: (_) => true,
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
        url
      );
      logResponse(response.statusCode!, response.data, 'get', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          print("рфрыврфы");
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
        data: body,
      );
      print(response.data);
      logResponse(response.statusCode!, response.data, 'patch', url);
      switch (response.statusCode) {
        case 200:
          return response.data;
        case 401:
          await refresh();
          logRequest('patch', url);
          Response response = await dio.patch(
            url,
            data: body,
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
      final refreshToken = await _storageService.getRefreshToken();
      Response response = await dio.post(
        'refresh',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $refreshToken'
          },
          validateStatus: (_) => true,
        )
      );
      logResponse(response.statusCode!, response.data, 'post', 'refresh');
      if (response.statusCode == 200) {
        await _storageService.setToken(
          response.data['payload']['access_token'],
          response.data['payload']['refresh_token'],
        );
        await init();
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
            '${body == null ? '' : '\nbody: $body'}'
            '${dio.options.headers}',
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
            '\nBody: ${_getPrettyJSONString(body)}',
        'RESPONSE',
        statusCode >= 200 && statusCode <= 299 ? 046 : 009
    ));
  }
}