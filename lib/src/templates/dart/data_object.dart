/// The template for data objects in Dart
const dataObjectDartTemplate = '''
import 'package:equatable/equatable.dart';

class {{name}} extends Equatable {
  {{#properties}}
  /// {{description}}
  {{type}} {{name}};

  {{/properties}}

  @override
  List<Object> get props => [
    {{#properties}}
    {{name}},
    {{/properties}}
  ];

  Map<String, dynamic> toJson() => {
    {{#properties}}
    '{{name}}': {{name}},
    {{/properties}}
  }
}
''';
