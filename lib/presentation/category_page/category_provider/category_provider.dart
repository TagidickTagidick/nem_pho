import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';

import '../models/product_model.dart';

abstract class ICategoryProvider {
  Future<void> getProducts(String id);
}

class CategoryProvider extends ICategoryProvider with ChangeNotifier {
  bool _isLoading = true;
  final ICategoryService _categoryService = CategoryService();
  List<ProductModel> _products = [];

  bool get isLoading => _isLoading;
  List<ProductModel> get products => _products;

  @override
  Future<void> getProducts(String id) async {
    print("вывавы");
    _products = await _categoryService.getProducts(id);
    _isLoading = false;
    notifyListeners();
  }
}