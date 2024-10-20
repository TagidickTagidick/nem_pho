import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';
import '../../../core/services/network_client.dart';

abstract class IProfileService {
  Future<UserModel> getUser();
}

class ProfileService extends IProfileService {
  final INetworkClient _networkClient = NetworkClient();

  @override
  Future<UserModel> getUser() async {
    Map<String, dynamic> user = await _networkClient.get('user');
    final UserModel userModel = UserModel.fromJson(user['user']);
    return userModel;
  }
}
