import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';
import '../parser_model/parser_model.dart';

class ObjectSchema {
  ObjectSchema({
    @required this.description,
    this.objectType = 'object',
    this.properties,
    this.enumValues,
    this.unknownEnumValue,
  });

  factory ObjectSchema.fromJson(Map json) {
    if (!(json['description'] is String)) {
      throw CheckedFromJsonException(
        json,
        'description',
        'ObjectSchema',
        'description must be a String',
      );
    }
    if (json['type'] == 'enum') {
      if (!(json['enumValues'] is YamlList)) {
        throw CheckedFromJsonException(
          json,
          'enumValues',
          'ObjectSchema',
          'enumvalues must be a List',
        );
      }

      final values = (json['enumValues'] as YamlList).map((value) {
        return EnumValueSchema.fromJson(value);
      }).toList();

      return ObjectSchema(
        description: json['description'],
        enumValues: values,
        unknownEnumValue: json['unknownEnumValue'] ?? 'Unknown',
        objectType: 'enum',
      );
    } else {
      if (!(json['properties'] is YamlList)) {
        throw CheckedFromJsonException(
          json,
          'properties',
          'ObjectSchema',
          'properties must be a List',
        );
      }

      final properies = (json['properties'] as YamlList).map((prop) {
        if (!(prop is YamlMap)) {
          throw CheckedFromJsonException(
            json,
            'properties',
            'ObjectSchema',
            'properties each property must be a map of string to property',
          );
        }

        return (prop as YamlMap).map(
          (key, value) =>
              MapEntry(key as String, PropertySchema.fromJson(value)),
        );
      }).toList();

      return ObjectSchema(
        description: json['description'],
        properties: properies,
      );
    }
  }

  final String description;
  final String objectType;
  final List<EnumValueSchema> enumValues;
  final String unknownEnumValue;
  final List<Map<String, PropertySchema>> properties;
}
