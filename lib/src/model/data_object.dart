import 'package:meta/meta.dart';
import 'model.dart';

/// {@template data_object}
/// An object of key-value pairs that lives in a database
/// {@endtemplate}
class DataObject extends NamedObject {
  /// {@macro data_object}
  const DataObject({
    @required this.name,
    @required this.properties,
    @required this.description,
  });

  /// The name of object.
  final String name;

  /// A short description of what this object is.
  final String description;

  /// The properties that make up the object.
  final List<Property> properties;

  @override
  List<Object> get props => [name, properties, description];
}
