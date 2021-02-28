import 'package:scribe/scribe.dart';
import 'package:test/test.dart';

void main() {
  group('SchemaParser', () {
    group('parse', () {
      test('testing', () {
        const yaml = '''

Customer:
  description: The customer object as returned by Firestore.
  properties:
  - id:
      type: string
      description: The unique guid for this customer. Matches the id from Firebase Auth.
  - First Name:
      type: string
      description: The first name of the customer.
  - Last Name:
      type: string
      description: The last name of the customer.
  - Email Address:
      type: string
      description: The email address of the customer.
''';

        final objects = SchemaParser().parse(yaml);
        print(TypeScriptGenerator().generate(objects));
      });
    });
  });
}
