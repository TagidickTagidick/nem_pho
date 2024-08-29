import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nem_pho/core/network_client.dart';
import 'package:nem_pho/presentation/loading_page/loading_service.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([NetworkClient])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockNetworkClient();

      when(client
          .get('healthcheck'))
          .thenAnswer((_) async => {'success': false});

      expect(await LoadingService(networkClient: client).getHealthCheck(), isTrue);
    });
  });
}