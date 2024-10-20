import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/presentation/product_page/models/topping_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class IProductService {
  Future<ProductModel> getProduct(String id);
  Future<List<ToppingModel>> getToppings();
}

class ProductService extends IProductService {
  ProductService({
    required final INetworkClient networkClient
  }): _networkClient = networkClient;

  final INetworkClient _networkClient;

  @override
  Future<ProductModel> getProduct(String id) async {
    Map<String, dynamic> products = await _networkClient.get('products/$id');
    return ProductModel.fromJson(products["payload"]);
  }

  @override
  Future<List<ToppingModel>> getToppings() async {
    Map<String, dynamic> toppings = await _networkClient.get('');
    return ToppingModel.listFromJson(toppings);
  }
}