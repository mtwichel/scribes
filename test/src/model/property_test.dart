import 'package:scribes/scribes.dart';
import 'package:test/test.dart';

void main() {
  group('Property', () {
    test('supports value comparisons', () async {
      expect(
        Property(name: 'car', type: IntType(), description: 'a car'),
        Property(name: 'car', type: IntType(), description: 'a car'),
      );
    });
  });
}
