import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/product_page/models/topping_model.dart';

import '../../../core/models/product_model.dart';
import '../product_service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({
    required IProductService productService
  }): _productService = productService;

  int _price = 0;
  bool _isLoading = true;
  final IProductService _productService;
  late final ProductModel _product;
  final List<ToppingModel> _toppings = [];
  final List<ToppingModel> _myToppings = [];

  int get price => _price;
  bool get isLoading => _isLoading;
  ProductModel get product => _product;
  List<ToppingModel> get toppings => _toppings;
  List<ToppingModel> get myToppings => _myToppings;

  Future<void> getProduct(String id) async {
    _product = await _productService.getProduct(id);
    // if (_product.isTopping) {
    //   _toppings = await _productService.getToppings();
    // } else {
    //   _toppings = [];
    // }
    _isLoading = false;
    notifyListeners(); //изменение стейта
  }

  ///По нажатию на виджет топпинга изменение статуса топпинга и изменение цены всего продукта
  void onTapTopping(int index) {
    if (_myToppings.contains(_toppings[index])) {
      _myToppings.remove(_toppings[index]);
      _price -= _toppings[index].price;
    } else {
      _myToppings.add(_toppings[index]);
      _price += _toppings[index].price;
    }
    notifyListeners();
  }
}