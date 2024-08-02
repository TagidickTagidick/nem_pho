import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service.dart';

import '../../firebase_options.dart';

class LoadingProvider with ChangeNotifier {
  Future<void> init() async {
    final IStorageService storageService = StorageService();
    await storageService.initializeDataBase();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final ILoadingService loadingService = LoadingService();
    await loadingService.getHealthCheck();
    await loadingService.getVersions();
  }
}