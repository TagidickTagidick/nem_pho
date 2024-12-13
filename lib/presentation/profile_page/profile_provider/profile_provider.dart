import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/services/common_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_service/profile_service.dart';
import 'package:nem_pho/presentation/profile_page/profile_models/user_model.dart';

import '../../../core/services/appmetrica_service.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required final IProfileService profileService,
    required final ICommonService commonService
  }): _profileService = profileService,
        _commonService = commonService;

  final IProfileService _profileService;
  final ICommonService _commonService;
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

    _user = await _commonService.patchUser(
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
    AppMetricaService().sendLoadingPageEvent('ProfilePage');
    _isLoading = true;
    notifyListeners();
    _user = await _commonService.getUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    await _profileService.deleteUser();
    await _profileService.deleteStorage();
  }
}