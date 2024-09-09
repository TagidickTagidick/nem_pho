import 'package:flutter/cupertino.dart';

import '../../../core/models/product_model.dart';
import '../product_service/product_service.dart';

abstract class IProductProvider {
  Future<void> getProduct(String id);
}

class ProductProvider extends IProductProvider with ChangeNotifier {
  ProductProvider({
    required IProductService productService
  }): _productService = productService;

  bool _isLoading = true;
  final IProductService _productService;
  late final ProductModel product;

  bool get isLoading => _isLoading;

  @override
  Future<void> getProduct(String id) async {
    product = await _productService.getProduct(id);
    _isLoading = false;
    notifyListeners();
  }
}