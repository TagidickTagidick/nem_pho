import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/cart_page/cart_service/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final ICartService _cartService = CartService();
  late final List<ProductModel> _products;

  Future<void> getProducts(String id) async {
    _products = await _cartService.getProducts(id);
    notifyListeners();
  }
}