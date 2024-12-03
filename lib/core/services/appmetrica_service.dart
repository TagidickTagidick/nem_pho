import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:nem_pho/core/constants/api_keys.dart';

abstract class IAppMetricaService {
  Future<void> init();
}

class AppMetricaService extends IAppMetricaService {
  @override
  Future<void> init() async {
    await AppMetrica.activate(AppMetricaConfig(ApiKeys.appMetricaKey));
    sendEvent('version 11');
  }

  Future<void> sendEvent(String name) async {
    AppMetrica.reportEventWithMap(name, {name: name});
    AppMetrica.reportEvent(name);
  }
}