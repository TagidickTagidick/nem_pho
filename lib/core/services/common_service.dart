import '../models/banner_model.dart';
import '../network_client.dart';

abstract class ICommonService {
  Future<List<BannerModel>> getBanners();
}

class CommonService extends ICommonService {
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      final INetworkClient networkClient = NetworkClient();
      final Map<String, dynamic> bannersMap = await networkClient.get('banners');
      return await bannersMap['payload'].map<BannerModel>((json) =>
          BannerModel.fromJson(json)).toList();
    } catch(e) {
      return [];
    }
  }
}