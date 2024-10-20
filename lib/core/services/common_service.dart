import '../../presentation/loading_page/models/menu_model.dart';
import '../models/banner_model.dart';
import 'network_client.dart';

abstract class ICommonService {
  Future<List<BannerModel>> getBanners();
  Future<List<MenuModel>> getMenu();
}

class CommonService extends ICommonService {
  final INetworkClient _networkClient = NetworkClient();
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

  @override
  Future<List<MenuModel>> getMenu() async {
    try {
      final Map<String, dynamic> menuMap = await _networkClient.get('menu');
      List<MenuModel> menu = [];
      for(var i in menuMap['payload']) {
        menu.add(MenuModel.fromJson(i));
      }
      return menu;
    }
    catch (_) {
      rethrow;
    }
  }
}