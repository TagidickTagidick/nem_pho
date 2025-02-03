import 'package:nem_pho/core/models/banner_model.dart';
import 'package:nem_pho/core/services/storage/istorage_service.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteStorageService extends IStorageService {

  static final SQFLiteStorageService _singleton = SQFLiteStorageService._internal();

  factory SQFLiteStorageService() {
    return _singleton;
  }

  SQFLiteStorageService._internal();

  late Database db;


  Future<void> init() async {
    db = await openDatabase(
        'my_db.db',
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Banners (id INTEGER PRIMARY KEY, url TEXT)'
          );
          await db.execute(
              'CREATE TABLE User (id INTEGER PRIMARY KEY, access_token TEXT, refresh_token TEXT)');
        });
  }

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<String?> getAccessToken() async {
    final maps = await db.query('User');

    return maps.firstOrNull?['access_token'] as String?;
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    final map = await db.query('Banners');
    final List<BannerModel> bannerModels = [];
    for(var banner in map) {
      bannerModels.add(BannerModel.fromJson(banner));
    }
    return bannerModels;
  }

  @override
  Future<String?> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> setBanners(List<BannerModel> banners) async {
    final listOfMaps = await db.query('Banners');
    if (listOfMaps.isNotEmpty) {
      for(var banner in banners) {
        await db.update(
            'Banners',
            banner.toMap()
        );
      }
      return;
    }
    for(var banner in banners) {
      await db.insert(
          'Banners',
          banner.toMap()
      );
    }
  }

  @override
  Future<void> setToken(String accessToken, String refreshToken) async {
    final maps = await db.query('User');

    if (maps.isNotEmpty) {
      await db.update(
        'User',
        {
          'access_token': accessToken,
          'refresh_token': refreshToken
        },
        whereArgs: [maps.first['id']],
      );

      return;
    }

    await db.insert(
        'User',
        {
          'access_token': accessToken,
          'refresh_token': refreshToken
        });
  }
}