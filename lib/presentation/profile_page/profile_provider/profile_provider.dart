import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/profile_page/profile_service/profile_service.dart';
import '../profile_models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final IProfileService _profileService = ProfileService();
  UserModel user = UserModel.mock;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> initUser() async {
    _isLoading = true;
    notifyListeners();
    user = await _profileService.getUser();
    _isLoading = false;
    notifyListeners();
  }
}