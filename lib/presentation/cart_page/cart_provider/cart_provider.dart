import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/cart_page/cart_service/cart_service.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({required final ICartService cartService, required final ICommonService commonService,})
  : _cartService = cartService, _commonService = commonService;

  final ICartService _cartService;
  final ICommonService _commonService;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ProductModel> _newProducts = [];
  List<ProductModel> get newProducts => _newProducts;

  List<ProductModel> _oldProducts = [];
  List<ProductModel> get oldProducts => _oldProducts;

  List<int> _counts = [];
  List<int> get counts => _counts;

  int _total = 0;
  int get total => _total;

  Future<void> getProducts() async {
    _isLoading = true;
    _oldProducts = await _commonService.getBasket();
    for (int i = 0; i < _oldProducts.length; i++) {
      _total += _oldProducts[i].price;
    }
    if (oldProducts.isNotEmpty) {
      _oldProducts.sort((a, b) => a.title.compareTo(b.title));
      if (oldProducts.length == 1) {
        _newProducts.add(oldProducts[0]);
        _counts.add(1);
      } else {
        int count = 0;
        for (int i = 1; i < _oldProducts.length; i++) {
          count++;
          if (_oldProducts[i].title != _oldProducts[i - 1].title) {
            _newProducts.add(_oldProducts[i - 1]);
            _counts.add(count);
            count = 0;
          }
        }
        count++;
        _newProducts.add(_oldProducts[_oldProducts.length - 1]);
        _counts.add(count);
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}