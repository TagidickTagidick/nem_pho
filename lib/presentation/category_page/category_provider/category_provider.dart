import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';
import 'package:nem_pho/core/models/product_model.dart';

abstract class ICategoryProvider {
  Future<void> getProducts(String id);
}

class CategoryProvider extends ICategoryProvider with ChangeNotifier {
  CategoryProvider({
    required final ICategoryService categoryService
  }): _categoryService = categoryService;
  bool _isLoading = true;
  final ICategoryService _categoryService;

  List<ProductModel> _products = [];

  bool get isLoading => _isLoading;
  List<ProductModel> get products => _products;

  @override
  Future<void> getProducts(String id) async {
    _products = await _categoryService.getProducts(id);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh(String id) async {
    _isLoading = true;
    notifyListeners();
    _products = await _categoryService.getProducts(id);
    _isLoading = false;
    notifyListeners();
  }
}