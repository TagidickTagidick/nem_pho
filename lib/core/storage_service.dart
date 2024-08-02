import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class IStorageService {
  Future<void> initializeDataBase();
  Future<void> setToken(String accessToken, String refreshToken);
  Future<String> getAccessToken();
  Future<String> getRefreshToken();
}

class StorageService extends IStorageService {

  late final Database? database;

  @override
  Future<void> initializeDataBase() async {
    database = await openDatabase(
        join(await getDatabasesPath(), 'user.db'),
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE user(id INT, access_token TEXT, refresh_token TEXT)'
          );
        },
      version: 1,
    );
  }

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    await database?.insert(
        'user',
        {
          'access_token': accessToken,
          'refresh_token': refreshToken
        },
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Future<String> getAccessToken() async {
    final List<Map<String, dynamic>> userMaps = await database!.query('user');
    return userMaps.first['access_token'];
  }

  @override
  Future<String> getRefreshToken() async {
    final List<Map<String, dynamic>> userMaps = await database!.query('user');
    return userMaps.first['refresh_token'];
  }
}