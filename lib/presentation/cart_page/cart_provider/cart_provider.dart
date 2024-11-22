import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/cart_page/cart_service/cart_service.dart';

class CartProvider extends ChangeNotifier {
  CartProvider({
    required final ICartService cartService,
    required final ICommonService commonService,
  }): _cartService = cartService, _commonService = commonService;

  final ICartService _cartService;
  final ICommonService _commonService;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final List<ProductModel> _newProducts = [];
  List<ProductModel> get newProducts => _newProducts;

  List<ProductModel> _oldProducts = [];

  final List<int> _counts = [];
  List<int> get counts => _counts;

  int _total = 0;
  int get total => _total;

  Future<void> getProducts() async {
    _isLoading = true;

    _oldProducts = await _commonService.getBasket();

    _commonService.getUser();

    for (int i = 0; i < _oldProducts.length; i++) {
      _total += _oldProducts[i].price;
    }
    if (_oldProducts.isNotEmpty) {
      _oldProducts.sort((a, b) => a.title.compareTo(b.title));
      if (_oldProducts.length == 1) {
        _newProducts.add(_oldProducts[0]);
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

  Future<void> addProduct(ProductModel product, int index) async {
    await _commonService.addProductToBasket(product.id);
    _counts[index]++;
    _total += product.price;
    notifyListeners();
  }

  Future<void> deleteProduct(ProductModel product, int index) async {
    // await _cartService.deleteProductFromBasket(product.id); ///TODO: Колян сделает
    if (_counts[index] == 1) {
      _newProducts.removeAt(index);
      _counts.removeAt(index);
    } else {
      _counts[index]--;
      _total -= product.price;
    }
    notifyListeners();
  }
}