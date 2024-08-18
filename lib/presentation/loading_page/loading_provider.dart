import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/loading_page/models/banner_model.dart';
import 'package:nem_pho/core/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service.dart';

import '../../firebase_options.dart';
import 'models/menu_model.dart';

abstract class ILoadingProvider{
  Future<void> init();
  Future<void> getVersions();
  Future<void> getHealthCheck();
  Future<List<BannerModel>> getBanners();
  Future<List<MenuModel>> getMenu();
  Future<void> getUser();
}

class LoadingProvider extends ILoadingProvider with ChangeNotifier {
  final ILoadingService _loadingService = LoadingService();
  final IStorageService _storageService = StorageService();
  @override
  Future<void> init() async {
    try{
      await _storageService.initializeDataBase();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<void> getVersions() async {
    await _loadingService.getVersions();
  }

  @override
  Future<void> getHealthCheck() async {
    await _loadingService.getHealthCheck();
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    final banners = await _loadingService.getBanners();

    if (banners.isEmpty) {
      final bannersFromStorage = await _storageService.getBanners();
      if (bannersFromStorage.isEmpty) {
        return [];
      }
      return bannersFromStorage;
    }

    final bannersFromStorage = await _storageService.getBanners();
    if (bannersFromStorage.isEmpty) {
      await _storageService.setBanners(banners);
    }

    return banners;
  }

  @override
  Future<List<MenuModel>> getMenu() async {
    try {
      return await _loadingService.getMenu();
    }
    catch (e) {
      return [];
    }
  }

  @override
  Future<void> getUser() async {
    final accessToken = await _storageService.getAccessToken();
    if(accessToken != null) {
      //TODO: щас колян сделает
    }
  }
}