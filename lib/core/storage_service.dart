import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/banner_model.dart';

abstract class IStorageService {
  Future<void> initializeDataBase();
  Future<void> setToken(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> setBanners(List<BannerModel> banners);
  Future<List<BannerModel>> getBanners();
}

class StorageService extends IStorageService {
  static final StorageService _singleton = StorageService._internal();

  factory StorageService() {
    return _singleton;
  }

  StorageService._internal();

  Database? database;

  @override
  Future<void> initializeDataBase() async {
    if (database != null) return;

    database = await openDatabase(
      join(await getDatabasesPath(), 'user.db', 'banners.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE user(id INT, access_token TEXT, refresh_token TEXT)'
        );
        db.execute(
            'CREATE TABLE banners(id INT, url TEXT)'
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    if (database == null) return;

    await database!.insert(
        'user',
        {
          'access_token': accessToken,
          'refresh_token': refreshToken
        },
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Future<String?> getAccessToken() async {
    if (database == null) return null;

    final List<Map<String, dynamic>> userMaps = await database!.query('user');
    return userMaps.firstOrNull?['access_token'];
  }

  @override
  Future<String?> getRefreshToken() async {
    if (database == null) return null;

    final List<Map<String, dynamic>> userMaps = await database!.query('user');
    return userMaps.firstOrNull?['refresh_token'];
  }

  @override
  Future<void> setBanners(List<BannerModel> banners) async {
    if (database == null) return;

    for(var banner in banners) {
      await database?.insert(
          'banners',
          banner.toMap()
      );
    }
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    if (database == null) return [];
    final List<Map<String, dynamic>> bannersMaps = await database!.query('banners');
    List<BannerModel> banners = [];
    for(var banner in bannersMaps) {
      banners.add(BannerModel.fromJson(banner));
    }
    return banners;
  }
}