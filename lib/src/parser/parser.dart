import 'package:checked_yaml/checked_yaml.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

import '../model/model.dart';
import 'parser_model/parser_model.dart';

class SchemaParser {
  List<NamedObject> parse(String schema) {
    final parsedYaml = parseYaml(schema);
    final convertedParsedYaml = parsedYaml.map(
      (key, value) => MapEntry(key.camelCase, value),
    );
    return convertedParsedYaml.entries.map((obj) {
      if (obj.value.objectType == 'object') {
        return schemaToDataObject(
          obj.key,
          obj.value,
          convertedParsedYaml.map(
            (name, obj) => MapEntry(name, obj.objectType),
          ),
        );
      } else if (obj.value.objectType == 'enum') {
        return schemaToEnumObject(obj.key, obj.value);
      } else {
        return null;
      }
    }).toList();
  }

  @visibleForTesting
  Map<String, ObjectSchema> parseYaml(String schema) {
    return checkedYamlDecode(
      schema,
      (e) => e.map(
        (key, value) => MapEntry(key as String, ObjectSchema.fromJson(value)),
      ),
    );
  }

  DataObject schemaToDataObject(
    String key,
    ObjectSchema schema,
    Map<String, String> otherObjects,
  ) {
    return DataObject(
      name: key,
      description: schema.description,
      properties: schema.properties
          .map(
            (prop) => schemaToProperty(
              prop.keys.first,
              prop.values.first,
              otherObjects,
            ),
          )
          .toList(),
    );
  }

  EnumObject schemaToEnumObject(String key, ObjectSchema schema) {
    return EnumObject(
      name: key,
      description: schema.description,
      unknownValue: schema.unknownEnumValue,
      values: schema.enumValues.map(schemaToEnumValue).toList(),
    );
  }

  EnumValue schemaToEnumValue(EnumValueSchema schema) {
    return EnumValue(
      val: schema.val,
      description: schema.description,
    );
  }

  Property schemaToProperty(
      String key, PropertySchema schema, Map<String, String> otherObjects) {
    return Property(
      name: key,
      type: schemaToType(schema.type, otherObjects),
      description: schema.description,
    );
  }

  DataType schemaToType(String typeString, Map<String, String> otherObjects) {
    final lowerCaseString = typeString.camelCase;
    if (lowerCaseString.startsWith('listOf')) {
      return ListType(
        schemaToType(
          RegExp(r'(?<=listOf).*').stringMatch(lowerCaseString),
          otherObjects,
        ),
      );
    }
    switch (lowerCaseString) {
      case 'string':
        return StringType();
      case 'integer':
      case 'int':
        return IntType();
      case 'double':
        return DoubleType();
      case 'boolean':
      case 'bool':
        return BooleanType();
      default:
        final type = otherObjects[lowerCaseString];

        if (type == 'object') {
          return DataObjectType(lowerCaseString);
        } else if (type == 'enum') {
          return EnumObjectType(lowerCaseString);
        } else {
          throw Exception('unknown element type $type');
        }
    }
  }
}
