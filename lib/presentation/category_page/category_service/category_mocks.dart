import 'package:nem_pho/presentation/category_page/category_service/category_service.dart';
import 'package:nem_pho/core/models/product_model.dart';

class CategoryMocks extends ICategoryService {

  @override
  Future<List<ProductModel>> getProducts(String id) async {
    return [ProductModel.mock];
  }
}