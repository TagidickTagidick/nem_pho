import 'package:nem_pho/presentation/product_page/product_service/product_service.dart';

import '../../../core/models/product_model.dart';

class ProductMocks extends ProductService {
  @override
  Future<ProductModel> getProduct(String id) async {
    return ProductModel.mock;
  }
}