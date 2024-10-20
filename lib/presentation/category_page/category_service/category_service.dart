import '../../../core/models/product_model.dart';
import '../../../core/services/network_client.dart';


abstract class ICategoryService {
  Future<List<ProductModel>> getProducts(String id);
}

class CategoryService extends ICategoryService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<List<ProductModel>> getProducts(String id) async {
    final Map<String, dynamic> productsMap = await _networkClient.get('menu/$id/products');
    return ProductModel.listFromJson(productsMap);
  }
}