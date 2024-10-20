import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';
import 'package:nem_pho/core/services/network_client.dart';

abstract class IProfileService {
  Future<UserModel> getUser();
}

class ProfileService extends IProfileService {
  ProfileService({
    required final INetworkClient networkClient
  }): _networkClient = networkClient;

  final INetworkClient _networkClient;

  @override
  Future<UserModel> getUser() async {
    Map<String, dynamic> user = await _networkClient.get('user');
    final UserModel userModel = UserModel.fromJson(user['user']);
    return userModel;
  }
}