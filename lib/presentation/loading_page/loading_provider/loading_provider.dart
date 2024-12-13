import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/version_model.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/loading_page/loading_service/loading_service.dart';
import 'package:nem_pho/firebase_options.dart';
import 'package:nem_pho/core/services/appmetrica_service.dart';

class LoadingProvider extends ChangeNotifier {
  LoadingProvider({
    required final ILoadingService loadingService,
    required final ICommonService commonService,
  }): _loadingService = loadingService;

  final ILoadingService _loadingService;

  Future<void> init() async {
    try{
      await _loadingService.initNetworkClient();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AppMetricaService().init();
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
}