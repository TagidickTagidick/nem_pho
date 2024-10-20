import 'package:nem_pho/core/models/version_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class ILoadingService {
  Future<bool> getHealthCheck();
  Future<List<VersionModel>> getVersions();
}

class LoadingService extends ILoadingService {
  LoadingService({
    required final NetworkClient networkClient
  }) : _networkClient = networkClient;

  final NetworkClient _networkClient;

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
}