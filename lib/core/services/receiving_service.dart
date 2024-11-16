import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nem_pho/core/services/storage_service.dart';

class ReceivingService {
  static StorageService getStorage() {
    return StorageService(
        storage: const FlutterSecureStorage(
            aOptions: AndroidOptions(
                encryptedSharedPreferences: true
            )
        )
    );
  }
}