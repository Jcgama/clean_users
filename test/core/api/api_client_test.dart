import 'package:clean_users/core/api/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiClient', () {
    test('configures Dio with the API base URL', () {
      final dio = ApiClient().getDio();

      expect(dio.options.baseUrl, 'https://dummyjson.com/');
    });

    test('creates a new Dio instance for each call', () {
      final apiClient = ApiClient();

      expect(apiClient.getDio(), isNot(same(apiClient.getDio())));
    });
  });
}
