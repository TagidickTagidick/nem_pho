import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class IProfileService {
  Future<UserModel> patchUser({
    String? birthday,
    String? building,
    int? entrance,
    int? flat,
    int? floor,
    String? name,
    String? sex,
    String? street,
  });
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
  Future<UserModel> patchUser({
    String? birthday,
    String? building,
    int? entrance,
    int? flat,
    int? floor,
    String? name,
    String? sex,
    String? street,
  }) async {
    Map<String, dynamic> userMap = await _networkClient.patch(
        'user',
        {
          if(birthday != null)
            'birthday': birthday,
          if(building != null)
            'building': building,
          if(entrance != null)
            'entrance': entrance,
          if(flat != null)
            'flat': flat,
          if(floor != null)
            'floor': floor,
          if(name != null)
            'name': name,
          if(sex != null)
            'sex': sex,
          if(street != null)
            'street': street,
        }
    );
    final UserModel userModel = UserModel.fromJson(userMap['user']);
    return userModel;
  }

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