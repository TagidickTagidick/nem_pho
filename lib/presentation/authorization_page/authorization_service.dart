import '../../core/services/network_client.dart';

abstract class IAuthorizationService {
  Future<Map<String, dynamic>> register(String phone);
}

class AuthorizationService extends IAuthorizationService {
  final INetworkClient _networkClient = NetworkClient();

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