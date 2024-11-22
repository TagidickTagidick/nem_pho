import 'package:nem_pho/core/services/network_client.dart';

abstract class ICartService {
  Future<void> deleteProductFromBasket(int productId);
}

class CartService extends ICartService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<void> deleteProductFromBasket(int productId) async {
    await _networkClient.delete('/basket/$productId');
  }
}