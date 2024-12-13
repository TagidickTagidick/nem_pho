import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:nem_pho/core/constants/api_keys.dart';

abstract class IAppMetricaService {
  Future<void> init();
  Future<void> sendLoadingPageEvent(String name);
}

class AppMetricaService extends IAppMetricaService {
  @override
  Future<void> init() async {
    await AppMetrica.activate(AppMetricaConfig(ApiKeys.appMetricaKey));
  }

  @override
  Future<void> sendLoadingPageEvent(String name) async {
    AppMetrica.reportEventWithMap(name, {name: 'Загрузка страницы'});
  }
}