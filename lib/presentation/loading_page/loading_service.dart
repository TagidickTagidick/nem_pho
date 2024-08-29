import '../../core/models/version_model.dart';
import '../../core/network_client.dart';
import 'models/menu_model.dart';

abstract class ILoadingService {
  Future<bool> getHealthCheck();
  Future<List<VersionModel>> getVersions();
  Future<List<MenuModel>> getMenu();
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

  @override
  Future<List<MenuModel>> getMenu() async {
    try {
      final Map<String, dynamic> menuMap = await _networkClient.get('menu');
      List<MenuModel> menu = [];
      for(var i in menuMap['payload']) {
        menu.add(MenuModel.fromJson(i));
      }
      return menu;
    }
    catch (_) {
      rethrow;
    }
  }
}