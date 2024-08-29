import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/services/common_service.dart';

import '../storage_service.dart';

abstract class ICommonProvider {
  Future<void> getBanners();
}

class CommonProvider extends ICommonProvider with ChangeNotifier {
  final ICommonService _commonService = CommonService();
  final IStorageService _storageService = StorageService();

  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;

  @override
  Future<List<BannerModel>> getBanners() async {
    _banners = await _commonService.getBanners();

    if (banners.isEmpty) {
      final bannersFromStorage = await _storageService.getBanners();
      if (bannersFromStorage.isEmpty) {
        _banners = [];
        notifyListeners();
      }
      _banners = bannersFromStorage;
      notifyListeners();
    }

    final bannersFromStorage = await _storageService.getBanners();
    if (bannersFromStorage.isEmpty) {
      await _storageService.setBanners(banners);
    }

    notifyListeners();

    return [];
  }
}