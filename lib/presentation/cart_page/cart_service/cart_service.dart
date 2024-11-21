import 'package:nem_pho/core/models/product_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class ICartService {
}

class CartService extends ICartService {
  final INetworkClient _networkClient = NetworkClient();

}