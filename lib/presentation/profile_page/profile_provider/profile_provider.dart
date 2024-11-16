import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/profile_page/profile_service/profile_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required final IProfileService profileService,
  }): _profileService = profileService;

  final IProfileService _profileService;
  UserModel? _user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UserModel? get user => _user;

  Future<void> save({
    String? birthday,
    String? building,
    int? entrance,
    int? flat,
    int? floor,
    String? name,
    String? sex,
    String? street,
  }) async {
    _isLoading = true;
    notifyListeners();
    _user = await _profileService.patchUser(
        birthday: birthday,
        building: building,
        entrance: entrance,
        flat: flat,
        floor: floor,
        name: name,
        sex: sex,
        street: street
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> initUser() async {
    _isLoading = true;
    notifyListeners();
    _user = await _profileService.getUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    await _profileService.deleteUser();
    await _profileService.deleteStorage();
  }
}