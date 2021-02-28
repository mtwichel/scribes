import 'package:meta/meta.dart';

import 'model.dart';

/// {@template enum_object}
/// An object the only allows discrete values.
/// {@endtemplate}
class EnumObject extends NamedObject {
  /// {@macro enum_object}
  const EnumObject({
    @required this.name,
    @required this.values,
    @required this.description,
    @required this.unknownValue,
  });

  /// The name of object.
  final String name;

  /// A short description of what this object is.
  final String description;

  /// The valid options in the enum.
  final List<EnumValue> values;

  /// The value to use if unknown string representation is found.
  final String unknownValue;

  @override
  List<Object> get props => [name, values, description];
}
