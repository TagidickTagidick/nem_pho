import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/version_model.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service/loading_service.dart';

import 'package:nem_pho/core/services/network_client.dart';
import 'package:nem_pho/firebase_options.dart';

class LoadingProvider extends ChangeNotifier {
  LoadingProvider({
    required final ILoadingService loadingService,
    required final IStorageService storageService
  }): _loadingService = loadingService,
        _storageService = storageService;

  final ILoadingService _loadingService;
  final IStorageService _storageService;

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

  Future<bool> getHealthCheck() async {
    return await _loadingService.getHealthCheck();
  }

  Future<List<VersionModel>> getVersions() async {
    return await _loadingService.getVersions();
  }

  Future<void> getUser() async {
    final accessToken = await _storageService.getAccessToken();
    if(accessToken != null) {
      //TODO: Колян когда-нибудь доделает
    }
  }
}