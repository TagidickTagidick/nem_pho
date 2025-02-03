import 'package:nem_pho/core/services/storage/istorage_service.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class IProfileService {
  Future<void> deleteUser();
  Future<void> deleteStorage();
}

class ProfileService extends IProfileService {
  ProfileService({
    required final INetworkClient networkClient,
    required final IStorageService storageService
  }): _networkClient = networkClient,
        _storageService = storageService;

  final INetworkClient _networkClient;
  final IStorageService _storageService;

  @override
  Future<void> deleteUser() async {
    await _networkClient.delete('user');
    await _storageService.clear();
  }

  @override
  Future<void> deleteStorage() async {
    await _storageService.clear();
  }
}