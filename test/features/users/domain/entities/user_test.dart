import 'package:clean_users/features/users/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('stores its id, first name, and email', () {
      final user = User(id: 7, firstName: 'Ada', email: 'ada@example.com');

      expect(user.id, 7);
      expect(user.firstName, 'Ada');
      expect(user.email, 'ada@example.com');
    });
  });
}
