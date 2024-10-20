import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/version_model.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service.dart';

import '../../core/services/network_client.dart';
import '../../firebase_options.dart';

abstract class ILoadingProvider{
  Future<void> init();
  Future<void> getVersions();
  Future<void> getHealthCheck();
  Future<void> getUser();
}

class LoadingProvider extends ILoadingProvider with ChangeNotifier {
  final ILoadingService _loadingService = LoadingService(networkClient: NetworkClient());
  final IStorageService _storageService = StorageService();

  @override
  Future<void> init() async {
    try{
      await NetworkClient().init();
      await _storageService.initializeDataBase();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch(e) {
      print(e);
    }
  }

  @override
  Future<bool> getHealthCheck() async {
    return await _loadingService.getHealthCheck();
  }

  @override
  Future<List<VersionModel>> getVersions() async {
    return await _loadingService.getVersions();
  }

  @override
  Future<void> getUser() async {
    final accessToken = await _storageService.getAccessToken();
    if(accessToken != null) {
      //TODO: Колян когда-нибудь доделает
    }
  }
}