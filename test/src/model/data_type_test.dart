import 'package:scribes/scribes.dart';
import 'package:test/test.dart';

void main() {
  group('ListType', () {
    test('supports value comparisons', () async {
      expect(
        ListType(StringType()),
        ListType(StringType()),
      );
    });
  });
}
