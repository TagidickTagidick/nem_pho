import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nem_pho/core/constants/storage_constants.dart';
import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/services/storage/istorage_service.dart';

class StorageService extends IStorageService {
  StorageService({
    required final FlutterSecureStorage storage
  }): _storage = storage;

  final FlutterSecureStorage _storage;

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    await _storage.write(
        key: StorageConstants.accessToken,
        value: accessToken
    );
    await _storage.write(
        key: StorageConstants.refreshToken,
        value: refreshToken
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(
        key: StorageConstants.accessToken
    );
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(
        key: StorageConstants.refreshToken
    );
  }

  @override
  Future<void> setBanners(List<BannerModel> banners) async {
    for (var banner in banners) {
      await _storage.write(
          key: StorageConstants.banners,
          value: banner.toMap().toString()
      );
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    return [];
    // final String? bannersString = await _storage.read(key: 'banners');
    // if (bannersString == null) return [];
    // final Map<>jsonDecode(bannersString);
    // final List<Map<String, dynamic>> bannersMaps = await _storage.read(key: 'banners');
    // List<BannerModel> banners = [];
    // for(var banner in bannersMaps) {
    //   banners.add(BannerModel.fromJson(banner));
    // }
    // return banners;
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}