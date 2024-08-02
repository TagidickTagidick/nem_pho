import '../../core/models/version_model.dart';
import '../../core/network_client.dart';

abstract class ILoadingService {
  Future<bool> getHealthCheck();
  Future<List<VersionModel>> getVersions();
}

class LoadingService extends ILoadingService {
  @override
  Future<bool> getHealthCheck() async {
    try {
      final NetworkClient networkClient = INetworkClient();
      return (await networkClient.get('healthcheck'))['success'];
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<VersionModel>> getVersions() async {
    try {
      final INetworkClient networkClient = INetworkClient();
      final Map<String, dynamic> versionMap = await networkClient.get('versions');
      return await versionMap['versions'].map<VersionModel>((json) =>
          VersionModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}