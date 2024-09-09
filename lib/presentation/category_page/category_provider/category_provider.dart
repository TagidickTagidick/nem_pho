import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';

import '../../../core/models/product_model.dart';

abstract class ICategoryProvider {
  Future<void> getProducts(String id);
}

class CategoryProvider extends ICategoryProvider with ChangeNotifier {
  CategoryProvider({
    required ICategoryService categoryService
}): _categoryService = categoryService;
  bool _isLoading = true;
  final ICategoryService _categoryService;
  List<ProductModel> _products = [];

  bool get isLoading => _isLoading;
  List<ProductModel> get products => _products;

  @override
  Future<void> getProducts(String id) async {
    print("вывавы");
    _products = await _categoryService.getProducts(id);
    _isLoading = false;
    print("фвррфвырфывфы");
    notifyListeners();
  }
}