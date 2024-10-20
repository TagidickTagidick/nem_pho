import 'package:flutter/cupertino.dart';
import 'package:nem_pho/core/services/storage_service.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_service/authorization_service.dart';

class AuthorizationProvider extends ChangeNotifier {
  AuthorizationProvider({
    required final IAuthorizationService authorizationService,
    required final IStorageService storageService
  }): _authorizationService = authorizationService,
        _storageService = storageService;

  final IAuthorizationService _authorizationService;
  final IStorageService _storageService;

  Future<bool> register(String phone) async {
    final Map<String, dynamic> registrationMap = await _authorizationService.register(phone);
    await _storageService.setToken(
      registrationMap['payload']['access_token'],
      registrationMap['payload']['refresh_token'],
    );
    return true;
  }
}