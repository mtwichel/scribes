import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'model.dart';

/// {@template property}
/// A single field in the object map.
/// {@endtemplate}
class Property extends Equatable {
  /// {@macro property}
  const Property({
    @required this.name,
    @required this.type,
    @required this.description,
    this.optional = false,
  });

  /// The name of the field.
  final String name;

  /// The data type of the field.
  final DataType type;

  /// A brief description of the property to be used in a doc comment.
  final String description;

  /// If true, this property is optional in an object.
  final bool optional;

  @override
  List<Object> get props => [name, type];
}
