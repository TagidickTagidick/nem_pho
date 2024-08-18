import '../loading_page/models/banner_model.dart';
import '../loading_page/models/menu_model.dart';

class MainParameters {
  final List<BannerModel> banners;
  final List<MenuModel> menu;

  MainParameters({
    required this.menu,
    required this.banners
  });
}