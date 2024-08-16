import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service.dart';

import '../../firebase_options.dart';

abstract class ILoadingProvider{
  Future<void> init();
  Future<void> getVersions();
  Future<void> getHealthCheck();
  Future<void> getBanners();
  Future<void> getMenu();
}

class LoadingProvider extends ILoadingProvider with ChangeNotifier {
  final ILoadingService loadingService = LoadingService();
  @override
  Future<void> init() async {
    try{
      final IStorageService storageService = StorageService();
      await storageService.initializeDataBase();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<void> getVersions() async {
    await loadingService.getVersions();
  }

  @override
  Future<void> getHealthCheck() async {
    await loadingService.getHealthCheck();
  }

  @override
  Future<void> getBanners() async {
    await loadingService.getBanners();
  }

  @override
  Future<void> getMenu() async {
    await loadingService.getMenu();
  }
}