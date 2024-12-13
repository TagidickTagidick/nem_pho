import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/models/order_model.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/loading_page/models/menu_model.dart';

class CommonProvider extends ChangeNotifier {
  CommonProvider({required final ICommonService commonService})
      : _commonService = commonService;
  final ICommonService _commonService;

  List<MenuModel> _menu = [];
  List<MenuModel> get menu => _menu;

  bool _isUser = false;
  bool get isUser => _isUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isBannersLoading = false;
  bool get isBannersLoading => _isBannersLoading;

  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  bool _isWorking = true;
  bool get isWorking => _isWorking;

  List<ProductModel> _basket = [];
  List<ProductModel> get basket => _basket;

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => _orders;

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

  Future<void> getBasketAndOrders() async {
    _isUser = await _commonService.checkIsUser();
    if (_isUser) {
      _basket = await _commonService.getBasket();
      _orders = await _commonService.getOrders();
    }
    notifyListeners();
  }

  void addProductToBasket({
    required ProductModel product,
    required int price,
    required List<String> toppingIds,
  }) async {
    await _commonService.addProductToBasket(
        productId: product.id,
        price: price,
        toppingIds: toppingIds
    );
    _basket.add(product);
    notifyListeners();
  }

  void changeUser() {
    _isUser = true;
    notifyListeners();
  }
}