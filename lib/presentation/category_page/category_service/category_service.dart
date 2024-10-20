import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class ICategoryService {
  Future<List<ProductModel>> getProducts(String id);
}

class CategoryService extends ICategoryService {
  CategoryService({
    required final INetworkClient networkClient
  }): _networkClient = networkClient;

  final INetworkClient _networkClient;

  @override
  Future<List<ProductModel>> getProducts(String id) async {
    final Map<String, dynamic> productsMap = await _networkClient.get('menu/$id/products');
    return ProductModel.listFromJson(productsMap);
  }
}