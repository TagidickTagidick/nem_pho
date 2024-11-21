import 'package:nem_pho/core/models/version_model.dart';
import 'package:nem_pho/core/services/network_client.dart';
import 'package:nem_pho/core/services/storage_service.dart';

import '../../../core/models/product_model.dart';

abstract class ILoadingService {
  Future<bool> getHealthCheck();
  Future<List<VersionModel>> getVersions();
  Future<void> initNetworkClient();
  Future<String?> getAccessToken();
}

class LoadingService extends ILoadingService {
  LoadingService({
    required final INetworkClient networkClient,
    required final IStorageService storageService
  }) : _networkClient = networkClient,
        _storageService = storageService;

  final INetworkClient _networkClient;
  final IStorageService _storageService;

  @override
  Future<bool> getHealthCheck() async {
    try {
      return (await _networkClient.get('healthcheck'))['success'];
    } catch (e, trace) {
      print(trace);
      return false;
    }
  }

  @override
  Future<List<VersionModel>> getVersions() async {
    try {
      final Map<String, dynamic> versionMap = await _networkClient.get('versions');
      return await versionMap['versions'].map<VersionModel>((json) =>
          VersionModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> initNetworkClient() async {
    await _networkClient.init();
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storageService.getAccessToken();
  }
}