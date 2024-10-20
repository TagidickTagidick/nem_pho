import 'package:nem_pho/core/models/product_model.dart';
import '../../../core/services/network_client.dart';

abstract class ICartService {
  Future<List<ProductModel>> getProducts(String id);
}

class CartService extends ICartService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<List<ProductModel>> getProducts(String id) async {
    Map<String, dynamic> product = await _networkClient.get(''); //TODO: вставить ссылочку
    return ProductModel.listFromJson(product);
  }
}