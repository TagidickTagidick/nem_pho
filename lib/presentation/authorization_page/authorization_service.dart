import 'package:nem_pho/core/network_client.dart';

abstract class IAuthorizationService {
  Future<Map<String, dynamic>> register(String phone);
}

class AuthorizationService extends IAuthorizationService {
  final NetworkClient _networkClient = INetworkClient();

  @override
  Future<Map<String, dynamic>> register(String phone) async {
    return await _networkClient.post(
        'register',
        {
          'phone': phone
        }
    );
  }
}