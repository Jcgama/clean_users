import 'dart:convert';
import 'dart:typed_data';

import 'package:clean_users/features/users/data/datasource/users_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UsersRemoteDatasource', () {
    test('requests users and parses the response', () async {
      final adapter = FakeHttpClientAdapter(
        statusCode: 200,
        body: jsonEncode({
          'users': [
            {'id': 7, 'firstName': 'Ada', 'email': 'ada@example.com'},
          ],
        }),
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com/'))
        ..httpClientAdapter = adapter;
      final datasource = UsersRemoteDatasource(dio);

      final users = await datasource.getUsers();

      expect(adapter.requestPath, 'users');
      expect(users, hasLength(1));
      expect(users.single.id, 7);
      expect(users.single.firstName, 'Ada');
      expect(users.single.email, 'ada@example.com');
    });

    test('throws when the response status is not successful', () async {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://example.com/',
          validateStatus: (_) => true,
        ),
      )..httpClientAdapter = FakeHttpClientAdapter(statusCode: 503, body: '{}');
      final datasource = UsersRemoteDatasource(dio);

      await expectLater(
        datasource.getUsers(),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            'Exception: Failed to load users',
          ),
        ),
      );
    });
  });
}

class FakeHttpClientAdapter implements HttpClientAdapter {
  FakeHttpClientAdapter({required this.statusCode, required this.body});

  final int statusCode;
  final String body;
  String? requestPath;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestPath = options.path;
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
