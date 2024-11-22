import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/loading_page/models/menu_model.dart';
import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/services/network_client.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';

abstract class ICommonService {
  Future<List<BannerModel>> getBanners();
  Future<List<MenuModel>> getMenu();
  Future<List<BannerModel>> getBannersFromStorage();
  Future<void> setBannersToStorage(List<BannerModel> banners);
  Future<String?> getAccessTokenFromStorage();
  Future<bool> checkIsUser();
  Future<List<ProductModel>> getBasket();
  Future<void> addProductToBasket(String productId);
  Future<UserModel> getUser();
}

class CommonService extends ICommonService {
  CommonService({
    required final INetworkClient networkClient,
    required final IStorageService storageService
  }): _networkClient = networkClient,
        _storageService = storageService;

  final INetworkClient _networkClient;
  final IStorageService _storageService;

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

  @override
  Future<List<BannerModel>> getBannersFromStorage() async {
    return await _storageService.getBanners();
  }

  @override
  Future<void> setBannersToStorage(List<BannerModel> banners) async {
    _storageService.setBanners(banners);
  }

  @override
  Future<String?> getAccessTokenFromStorage() async {
    return await _storageService.getAccessToken();
  }

  @override
  Future<bool> checkIsUser() async {
    final accessToken = await _storageService.getAccessToken();
    return accessToken != null;
  }

  @override
  Future<List<ProductModel>> getBasket() async {
    try {
      final Map<String, dynamic> basketMap = await _networkClient.get('basket');
      return await basketMap['payload'].map<ProductModel>((json) =>
          ProductModel.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addProductToBasket(String productId) async {
    await _networkClient.post(
        '/basket',
        {
          'product_id': productId,
          'topping_ids': [],
        }
    );
  }

  @override
  Future<UserModel> getUser() async {
    Map<String, dynamic> user = await _networkClient.get('user');
    final UserModel userModel = UserModel.fromJson(user['payload']);
    return userModel;
  }
}