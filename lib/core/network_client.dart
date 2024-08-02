import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:nem_pho/core/storage_service.dart';

import 'models/error_model.dart';

abstract class NetworkClient {
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> delete(String url);
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body);
  Future<void> refresh();
}

class INetworkClient extends NetworkClient {

  final IStorageService _storageService = StorageService();
  final dio = Dio();
  final String baseUrl = 'https://nem-pho-backend.onrender.com/';


  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    try {
      logRequest('post', url);
      final accessToken = await _storageService.getAccessToken();
      Response response = await dio.post(
        '$baseUrl$url',
        data: body,
        options: Options (
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      logResponse(response.statusCode!, response.data, 'post', url);
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.data);
        case 401:
          await refresh();
          logRequest('post', url);
          final accessToken = await _storageService.getAccessToken();
          Response response = await dio.post(
            '$baseUrl$url',
            data: body,
            options: Options (
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $accessToken'
              },
            ),
          );
          logResponse(response.statusCode!, response.data, 'post', url);
          switch (response.statusCode) {
            case 200:
              return jsonDecode(response.data);
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
      final accessToken = await _storageService.getAccessToken();
      Response response = await dio.get(
        '$baseUrl$url',
        options: Options (
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      logResponse(response.statusCode!, response.data, 'get', url);
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.data);
        case 401:
          await refresh();
          logRequest('get', url);
          final accessToken = await _storageService.getAccessToken();
          Response response = await dio.get(
            '$baseUrl$url',
            options: Options (
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $accessToken'
              },
            ),
          );
          logResponse(response.statusCode!, response.data, 'get', url);
          switch (response.statusCode) {
            case 200:
              return jsonDecode(response.data);
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
      final accessToken = await _storageService.getAccessToken();
      Response response = await dio.delete(
        '$baseUrl$url',
        options: Options (
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      logResponse(response.statusCode!, response.data, 'delete', url);
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.data);
        case 401:
          await refresh();
          logRequest('delete', url);
          final accessToken = await _storageService.getAccessToken();
          Response response = await dio.delete(
            '$baseUrl$url',
            options: Options (
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $accessToken'
              },
            ),
          );
          logResponse(response.statusCode!, response.data, 'delete', url);
          switch (response.statusCode) {
            case 200:
              return jsonDecode(response.data);
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
      logRequest('patch', url);
      final accessToken = await _storageService.getAccessToken();
      Response response = await dio.patch(
        '$baseUrl$url',
        options: Options (
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      logResponse(response.statusCode!, response.data, 'patch', url);
      switch (response.statusCode) {
        case 200:
          return jsonDecode(response.data);
        case 401:
          await refresh();
          logRequest('patch', url);
          Response response = await dio.patch(
            '$baseUrl$url',
            options: Options (
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $accessToken'
              },
            ),
          );
          logResponse(response.statusCode!, response.data, 'patch', url);
          switch (response.statusCode) {
            case 200:
              return jsonDecode(response.data);
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
          '${baseUrl}refresh',
          options: Options(
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $refreshToken'
            },
          )
      );
      logResponse(response.statusCode!, response.data, 'post', 'refresh');
      if (response.statusCode == 200) {
        await _storageService.setToken(
          jsonDecode(response.data)['payload']['access_token'],
          jsonDecode(response.data)['payload']['refresh_token'],
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

  void logRequest(String type, String url) {
    log('');
    log('----------------');
    log('Request:$baseUrl$url');
    log('type: $type');
    log('----------------');
    log('');
  }

  void logResponse(
      int statusCode,
      String body,
      String type,
      String url
      ) {
    log('----------------');
    log('type: $type');
    log('Request:$baseUrl$url');
    log('status: $statusCode');
    log('body: $body');
    log('----------------');
  }
}