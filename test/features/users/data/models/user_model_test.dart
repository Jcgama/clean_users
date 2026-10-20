import 'package:clean_users/features/users/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('creates a model from JSON', () {
      final user = UserModel.fromJson({
        'id': 7,
        'firstName': 'Ada',
        'email': 'ada@example.com',
      });

      expect(user.id, 7);
      expect(user.firstName, 'Ada');
      expect(user.email, 'ada@example.com');
    });

    test('converts a model to JSON', () {
      final user = UserModel(id: 7, firstName: 'Ada', email: 'ada@example.com');

      expect(user.toJson(), {
        'id': 7,
        'firstName': 'Ada',
        'email': 'ada@example.com',
      });
    });
  });
}
