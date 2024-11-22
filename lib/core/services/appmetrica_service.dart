import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:nem_pho/core/constants/api_keys.dart';

abstract class IAppMetricaService {
  Future<void> init();
}

class AppMetricaService extends IAppMetricaService {
  @override
  Future<void> init() async {
    AppMetrica.activate(AppMetricaConfig(ApiKeys.appMetricaKey));
  }

  Future<void> sendEvent(String name) async {
    AppMetrica.reportEventWithMap(name, {});
  }
}