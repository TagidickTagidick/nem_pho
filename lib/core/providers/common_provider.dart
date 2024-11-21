import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/loading_page/models/menu_model.dart';

class CommonProvider extends ChangeNotifier {
  CommonProvider({
    required final ICommonService commonService
  }): _commonService = commonService;
  final ICommonService _commonService;

  List<MenuModel> _menu = [];
  bool _isLoading = false;

  bool _isBannersLoading = false;
  List<BannerModel> _banners = [];
  bool _isWorking = true;

  List<BannerModel> get banners => _banners;
  bool get isBannersLoading => _isBannersLoading;
  bool get isWorking => _isWorking;
  List<MenuModel> get menu => _menu;
  bool get isLoading => _isLoading;

  List<ProductModel> _basket = [];
  List<ProductModel> get basket => _basket;

  Future<List<BannerModel>> getBanners() async {
    _isBannersLoading = true;
    notifyListeners();
    _banners = await _commonService.getBanners();
    if (banners.isEmpty) {
      final bannersFromStorage = await _commonService.getBannersFromStorage();
      if (bannersFromStorage.isEmpty) {
        _banners = [];
        notifyListeners();
      }
      _banners = bannersFromStorage;
      notifyListeners();
    }

    final bannersFromStorage = await _commonService.getBannersFromStorage();
    if (bannersFromStorage.isEmpty) {
      await _commonService.setBannersToStorage(banners);
    }
    _isBannersLoading = false;
    notifyListeners();

    return [];
  }

  ///Проверяет авторизован пользователь или нет
  Future<bool> checkIsAuthorized() async {
    final String? token = await _commonService.getAccessTokenFromStorage();
    return token != null;
  }

  Future<void> getIsWorking() async {
    final time = DateTime.now();
    DateTime startTime = DateTime(time.year, time.month, time.day, 11, 30);
    DateTime endTime = DateTime(time.year, time.month, time.day, 20, 30);
    if (time.isAfter(startTime) && time.isBefore(endTime)) {
      _isWorking = true;
    } else {
      _isWorking = false;
    }
    notifyListeners();
  }

  Future<void> getMenu() async {
    _isLoading = true;
    notifyListeners();
    _menu = await _commonService.getMenu();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getBasket() async {
    final isUser = await _commonService.checkIsUser();
    if (isUser) {
      _basket = await _commonService.getBasket();
      notifyListeners();
    }
  }

  void addProductToBasket(ProductModel product) async {
    await _commonService.addProductToBasket(product.id);
    _basket.add(product);
    notifyListeners();
  }
}