import 'package:equatable/equatable.dart';
import 'model.dart';

/// {@template data_type}
/// Represents the type for a [Property].
/// {@endtemplate}
abstract class DataType extends Equatable {
  /// {@macro data_type}
  const DataType();

  @override
  List<Object> get props => [];
}

/// A [DataType] representing a String
class StringType extends DataType {}

/// A [DataType] representing an int
class IntType extends DataType {}

/// A [DataType] representing a double
class DoubleType extends DataType {}

/// A [DataType] representing a boolean
class BooleanType extends DataType {}

/// {@template list_type}
/// A [DataType] represeting a List of type [elementType]
/// {@endtemplate}
class ListType extends DataType {
  /// {@macro list_type}
  const ListType(this.elementType);

  /// The [DataType] of each element of the list
  final DataType elementType;

  @override
  List<Object> get props => [elementType];
}

class DataObjectType extends DataType {
  const DataObjectType(this.identifier);

  final String identifier;

  @override
  List<Object> get props => [identifier];
}

class EnumObjectType extends DataType {
  const EnumObjectType(this.identifier);

  final String identifier;

  @override
  List<Object> get props => [identifier];
}
