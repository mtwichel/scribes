// ignore_for_file: lines_longer_than_80_chars

part of 'generators.dart';

/// {@template typescript_generator}
/// A [Generator] that produces typescript interfaces.
/// {@endtemplate}
class TypeScriptGenerator extends Generator {
  @override
  String _typeToString(DataType type) {
    if (type is StringType) {
      return 'string';
    } else if (type is IntType || type is DoubleType) {
      return 'number';
    } else if (type is ListType) {
      return '${_typeToString(type.elementType)}[]';
    } else if (type is BooleanType) {
      return 'boolean';
    } else if (type is DataObjectType) {
      return _objectNameFormatter(type.identifier);
    } else if (type is EnumObjectType) {
      return _objectNameFormatter(type.identifier);
    } else {
      throw Exception('Type not recognized.');
    }
  }

  String _typeToisA(DataType type, String obj) {
    var ans = '';
    if (type is ListType) {
      ans = '$ans(Array.isArray(input.${_propertyNameFormatter(obj)}) &&\n';
      ans =
          '$ans    input.${_propertyNameFormatter(obj)}.every((elem) => ${_typeToisA(type.elementType, 'elem')}))';
    } else if (type is DataObjectType) {
      ans = '${ans}isA${_objectNameFormatter(type.identifier)}($obj)';
    } else if (type is EnumObjectType) {
      ans = '${ans}isA${_objectNameFormatter(type.identifier)}($obj)';
    } else {
      ans =
          '${ans}typeof input.${_propertyNameFormatter(obj)} === "${_typeToString(type)}"';
    }
    return ans;
  }

  @override
  String generateDataObject(DataObject object) {
    var ans = '';

    ans = '$ans/** ${object.description} */\n';
    ans = '${ans}export interface ${_objectNameFormatter(object.name)} {\n';
    for (final property in object.properties) {
      ans = '$ans  /** ${property.description} */\n';
      ans =
          '$ans  ${_propertyNameFormatter(property.name)}${property.optional ? '?' : ''}: ${_typeToString(property.type)};\n\n';
    }
    ans = '$ans}\n\n';
    ans =
        '$ans/** A type guard to determine if an input is a ${_objectNameFormatter(object.name)}. */\n';
    ans =
        '${ans}export function isA${_objectNameFormatter(object.name)}(input: any): input is ${_objectNameFormatter(object.name)} {\n';

    ans = '$ans  return (\n';
    ans = '$ans    input &&\n';
    for (final property in object.properties) {
      final isLast = property == object.properties.last;

      if (property.optional) {
        ans = '$ans    (';
      } else {
        ans = '$ans    ';
      }

      final type = property.type;

      if (type is ListType) {
        ans = '$ans${_typeToisA(type, property.name)}';
      } else if (type is DataObjectType) {
        ans =
            '$ans${_typeToisA(type, 'input.${_propertyNameFormatter(property.name)}')}';
      } else if (type is EnumObjectType) {
        ans =
            '$ans${_typeToisA(type, 'input.${_propertyNameFormatter(property.name)}')}';
      } else {
        ans = '$ans${_typeToisA(type, property.name)}';
      }

      if (property.optional) {
        ans = '$ans || !input.${_propertyNameFormatter(property.name)})';
      }

      if (!isLast) {
        ans = '$ans &&\n';
      } else {
        ans = '$ans\n';
      }
    }
    ans = '$ans  );\n';
    ans = '$ans}\n';

    return ans;
  }

  @override
  String generateEnumObject(EnumObject object) {
    var ans = '';
    ans = '$ans/** ${object.description} */\n';
    ans = '${ans}export const enum ${_objectNameFormatter(object.name)} {\n';
    for (final value in object.values) {
      ans = '$ans  /** ${value.description} */\n';
      ans =
          '$ans  ${_enumValueFormatter(value.val)} = \'${_enumValueDbFormatter(value.val)}\',\n\n';
    }
    ans = '$ans}\n\n';
    ans =
        '$ans/** A type guard to determine if an input is a ${_objectNameFormatter(object.name)}. */\n';
    ans =
        '${ans}export function isA${_objectNameFormatter(object.name)}(input: any): input is ${_objectNameFormatter(object.name)} {\n';
    ans = '$ans  return (\n';
    ans = '$ans    typeof input === "string" && (\n';
    for (final value in object.values) {
      final isLast = value == object.values.last;

      ans =
          '$ans    input === "${_enumValueDbFormatter(value.val)}"${isLast ? '' : ' ||'}\n';
    }

    ans = '$ans    )\n  );\n';
    ans = '$ans}\n';
    return ans;
  }
}
