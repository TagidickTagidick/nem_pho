import 'package:nem_pho/core/services/network_client.dart';
import 'package:nem_pho/core/services/storage/istorage_service.dart';

abstract class IAuthorizationService {
  Future<Map<String, dynamic>> register(String phone);
  Future<void> setToken(String accessToken, String refreshToken);
  Future<void> refreshAccessToken();
}

class AuthorizationService extends IAuthorizationService {
  AuthorizationService({
    required final INetworkClient networkClient,
    required final IStorageService storageService,
  }): _networkClient = networkClient,
        _storageService = storageService;

  final INetworkClient _networkClient;
  final IStorageService _storageService;

  @override
  Future<Map<String, dynamic>> register(String phone) async {
    return await _networkClient.post(
        'register',
        {
          'phone': phone
        }
    );
  }

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    await _storageService.setToken(accessToken, refreshToken);
  }

  @override
  Future<void> refreshAccessToken() async {
    await _networkClient.init();
  }
}