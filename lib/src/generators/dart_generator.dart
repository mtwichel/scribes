// ignore_for_file: lines_longer_than_80_chars

part of 'generators.dart';

/// {@template dart_generator}
/// A [Generator] that produces dart classes that are:
/// - equatable
/// - have a toJson
/// - have a fromJson
/// {@endtemplate}
class DartGenerator extends Generator {
  @override
  String _typeToString(DataType type) {
    if (type is StringType) {
      return 'String';
    } else if (type is IntType) {
      return 'int';
    } else if (type is DoubleType) {
      return 'double';
    } else if (type is ListType) {
      return 'List<${_typeToString(type.elementType)}>';
    } else if (type is BooleanType) {
      return 'bool';
    } else if (type is DataObjectType) {
      return _objectNameFormatter(type.identifier);
    } else if (type is EnumObjectType) {
      return _objectNameFormatter(type.identifier);
    } else {
      throw Exception('Type not recognized.');
    }
  }

  String _typeFromJson(DataType type, String obj) {
    var ans = '';

    if (type is DataObjectType) {
      ans = '${_objectNameFormatter(type.identifier)}.fromJson($obj)';
    } else if (type is EnumObjectType) {
      ans = '_${type.identifier.camelCase}FromJson($obj)';
    } else if (type is ListType) {
      ans =
          'List.from($obj)\n          .map((elem) => ${_typeFromJson(type.elementType, 'elem')})\n          .toList()';
    } else {
      ans = obj;
    }

    return ans;
  }

  @override
  String generateDataObject(DataObject object) {
    var ans = '';

    ans =
        '${ans}class ${_objectNameFormatter(object.name)} extends Equatable {\n';
    ans = '$ans  const ${_objectNameFormatter(object.name)}({\n';
    for (final property in object.properties) {
      ans = '$ans    this.${_propertyNameFormatter(property.name)},\n';
    }
    ans = '$ans  });\n\n';
    ans =
        '$ans  /// Converts a [Map<String,dynamic>] to a [${_objectNameFormatter(object.name)}]\n';
    ans =
        '$ans  factory ${_objectNameFormatter(object.name)}.fromJson(Map<String, dynamic> json) => ${_objectNameFormatter(object.name)}(\n';
    for (final property in object.properties) {
      final type = property.type;
      if (type is DataObjectType) {
        ans =
            '$ans    ${_propertyNameFormatter(property.name)}: ${_typeFromJson(type, 'json[\'${_propertyNameFormatter(property.name)}\']')},\n';
      } else if (type is EnumObjectType) {
        ans =
            '$ans    ${_propertyNameFormatter(property.name)}: ${_typeFromJson(type, 'json[\'${_propertyNameFormatter(property.name)}\']')},\n';
      } else if (type is ListType) {
        ans =
            '$ans    ${_propertyNameFormatter(property.name)}: ${_typeFromJson(type, 'json[\'${_propertyNameFormatter(property.name)}\']')},\n';
      } else {
        ans =
            '$ans    ${_propertyNameFormatter(property.name)}: json[\'${_propertyNameFormatter(property.name)}\'],\n';
      }
    }
    ans = '$ans  );\n\n';

    for (final property in object.properties) {
      ans = '$ans  /// ${property.description}\n';
      ans =
          '$ans  final ${_typeToString(property.type)} ${_propertyNameFormatter(property.name)};\n\n';
    }

    ans = '$ans  @override\n';
    ans = '$ans  List<Object> get props => [\n';

    for (final property in object.properties) {
      ans = '$ans    ${_propertyNameFormatter(property.name)},\n';
    }

    ans = '$ans  ];\n\n';

    ans =
        '$ans  /// Converts a [${_objectNameFormatter(object.name)}] to a [Map<String,dynamic>]\n';
    ans = '$ans  Map<String, dynamic> toJson() => {\n';
    for (final property in object.properties) {
      final type = property.type;
      if (type is DataObjectType) {
        ans =
            '$ans    \'${_propertyNameFormatter(property.name)}\': ${_propertyNameFormatter(property.name)}.toJson(),\n';
      } else if (type is EnumObjectType) {
        ans =
            '$ans    \'${_propertyNameFormatter(property.name)}\': _${type.identifier.camelCase}ToJson(${_propertyNameFormatter(property.name)}),\n';
      } else {
        ans =
            '$ans    \'${_propertyNameFormatter(property.name)}\': ${_propertyNameFormatter(property.name)},\n';
      }
    }
    ans = '$ans  };\n';

    ans = '$ans}\n';

    return ans;
  }

  @override
  String generateEnumObject(EnumObject object) {
    var ans = '';

    ans = '$ans/// ${object.description}\n';
    ans = '${ans}enum ${_objectNameFormatter(object.name)} {\n';

    for (final value in object.values) {
      ans = '$ans  /// ${value.description}\n';
      ans = '$ans  ${_enumValueFormatter(value.val)},\n\n';
    }
    ans =
        '$ans  /// An unrecognized value for `${_objectNameFormatter(object.name)}`.\n';
    ans = '$ans  ${_enumValueFormatter(object.unknownValue)},\n\n';
    ans = '$ans}\n\n';

    ans =
        '$ans  /// Converts a [${_objectNameFormatter(object.name)}] to a [String]\n';
    ans =
        '${ans}String _${object.name.camelCase}ToJson(${_objectNameFormatter(object.name)} input) {\n';
    ans = '$ans  switch(input) {\n';
    for (final value in object.values) {
      ans =
          '$ans    case ${_objectNameFormatter(object.name)}.${_enumValueFormatter(value.val)}:\n';
      ans = '$ans      return \'${_enumValueDbFormatter(value.val)}\';\n';
    }
    ans = '$ans    default:\n';
    ans =
        '$ans      return \'${_enumValueDbFormatter(object.unknownValue)}\';\n';
    ans = '$ans  }\n';
    ans = '$ans}\n\n';

    ans =
        '$ans  /// Converts a [String] to a [${_objectNameFormatter(object.name)}]\n';
    ans =
        '$ans${_objectNameFormatter(object.name)} _${object.name.camelCase}FromJson(String input) {\n';
    ans = '$ans  switch(input) {\n';
    for (final value in object.values) {
      ans = '$ans    case \'${_enumValueDbFormatter(value.val)}\':\n';
      ans =
          '$ans      return ${_objectNameFormatter(object.name)}.${_enumValueFormatter(value.val)};\n';
    }
    ans = '$ans    default:\n';
    ans =
        '$ans      return ${_objectNameFormatter(object.name)}.${_enumValueFormatter(object.unknownValue)};\n';
    ans = '$ans  }\n';
    ans = '$ans}\n';
    return ans;
  }
}
