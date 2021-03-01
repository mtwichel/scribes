import 'package:scribes/scribes.dart';
import 'package:test/test.dart';

void main() {
  group('DataObject', () {
    test('supports value comparisons', () async {
      expect(
        const DataObject(
          name: 'car',
          description: 'A car that can drive on the road.',
          properties: [],
        ),
        const DataObject(
          name: 'car',
          description: 'A car that can drive on the road.',
          properties: [],
        ),
      );
    });
  });
}
