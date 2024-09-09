import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/network_client.dart';

abstract class IProductService {
  Future<ProductModel> getProduct(String id);
}

class ProductService extends IProductService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<ProductModel> getProduct(String id) async {
    Map<String, dynamic> products = await _networkClient.get(''); //TODO Вставить ссылочку
    return ProductModel.fromJson(products);
  }
}