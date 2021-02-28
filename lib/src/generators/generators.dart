import 'package:recase/recase.dart';
import '../model/model.dart';

part 'typescript_generator.dart';
part 'dart_generator.dart';

/// {@template generator}
/// An object that creates source code from Dart objects.
/// {@endtemplate}
abstract class Generator {
  /// {@macro generator}
  const Generator();

  /// A function that will convert [DataType] to string representations
  /// for a specific language.
  String _typeToString(DataType type);

  /// A function to format the name of an object. Defaults to `PascalCase`.
  String _objectNameFormatter(String objectName) => objectName.pascalCase;

  /// A function to format the name of a property. Defaults to `camelCase`.
  String _propertyNameFormatter(String objectName) => objectName.camelCase;

  /// A function to format an enum value in a database.
  ///  Defaults to `constantCase`.
  String _enumValueDbFormatter(String enumValueName) =>
      enumValueName.constantCase;

  /// A function to format the name of a enum value. Defaults to `camelCase`.
  String _enumValueFormatter(String enumValueName) => enumValueName.camelCase;

  /// The method to generate source code for a collection of named objects.
  String generate(List<NamedObject> objects) {
    var ans = '';

    for (final object in objects) {
      ans = '$ans${generateObject(object)}\n\n';
    }

    return ans;
  }

  /// The method to generate source code for a collection of named objects.
  String generateObject(NamedObject object) {
    if (object is DataObject) {
      return generateDataObject(object);
    } else if (object is EnumObject) {
      return generateEnumObject(object);
    } else {
      throw Exception('object was not of type DataObject or EnumObject');
    }
  }

  /// The method to generate source code for a single data object.
  String generateDataObject(DataObject object);

  /// The method to generate source code for a single data object.
  String generateEnumObject(EnumObject object);
}
