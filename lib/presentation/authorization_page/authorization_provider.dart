import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_service.dart';

abstract class IAuthorizationProvider {
  Future<bool> register(String phone);
}

class AuthorizationProvider extends IAuthorizationProvider with ChangeNotifier {
  final IAuthorizationService _authorizationService = AuthorizationService();
  final IStorageService _storageService = StorageService();

  @override
  Future<bool> register(String phone) async {
    final Map<String, dynamic> registrationMap = await _authorizationService.register(phone);
    await _storageService.setToken(
      registrationMap['payload']['access_token'],
      registrationMap['payload']['refresh_token'],
    );
    return true;
  }
}