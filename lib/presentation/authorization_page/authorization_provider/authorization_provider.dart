import 'package:flutter/cupertino.dart';
import 'package:nem_pho/presentation/authorization_page/authorization_service/authorization_service.dart';

class AuthorizationProvider extends ChangeNotifier {
  AuthorizationProvider({
    required final IAuthorizationService authorizationService,
  }): _authorizationService = authorizationService;

  final IAuthorizationService _authorizationService;

  Future<bool> register(String phone) async {
    final Map<String, dynamic> registrationMap = await _authorizationService.register(phone);
    await _authorizationService.setToken(
        registrationMap['payload']['access_token'],
        registrationMap['payload']['refresh_token']
    );
    await _authorizationService.refreshAccessToken();
    return true;
  }
}