import '../../../core/network_client.dart';
import '../../../core/models/product_model.dart';


abstract class ICategoryService {
  Future<List<ProductModel>> getProducts(String id);
}

class CategoryService extends ICategoryService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<List<ProductModel>> getProducts(String id) async {
    final productsMap = await _networkClient.get('menu/$id');
    return ProductModel.listFromJson(productsMap);
  }
}