import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/models/menu_model.dart';

import '../../core/models/version_model.dart';
import '../../core/network_client.dart';

abstract class ILoadingService {
  Future<bool> getHealthCheck();
  Future<List<VersionModel>> getVersions();
  Future<List<BannerModel>> getBanners();
  Future<List<MenuModel>> getMenu();
}

class LoadingService extends ILoadingService {
  @override
  Future<bool> getHealthCheck() async {
    try {
      final NetworkClient networkClient = INetworkClient();
      return (await networkClient.get('healthcheck'))['success'];
    } catch (e, trace) {
      print(trace);
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

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final NetworkClient networkClient = INetworkClient();
      final Map<String, dynamic> bannersMap = await networkClient.get('banners');
      return await bannersMap['banners'].map<BannerModel>((json) =>
          BannerModel.fromJson(json)).toList();
    } catch(e) {
      return [];
    }
  }

  @override
  Future<List<MenuModel>> getMenu() async {
    final NetworkClient networkClient = INetworkClient();
    final Map<String, dynamic> menuMap = await networkClient.get('menu');
    List<MenuModel> menu = [];
    for(var i in menuMap['payload']) {
      menu.add(MenuModel.fromJson(i));
    }
    return menu;
  }
}