import 'package:nem_pho/core/models/banner_model.dart';

abstract class IStorageService {
  Future<void> setToken(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> setBanners(List<BannerModel> banners);
  Future<List<BannerModel>> getBanners();
  Future<void> clear();
}