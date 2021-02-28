import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

class PropertySchema {
  PropertySchema({
    @required this.type,
    @required this.description,
    this.optional = false,
  });

  factory PropertySchema.fromJson(Map json) {
    if (!(json['type'] is String)) {
      throw CheckedFromJsonException(
        json,
        'type',
        'PropertySchema',
        'type must be a String in PropertySchema',
      );
    }
    if (!(json['description'] is String)) {
      throw CheckedFromJsonException(
        json,
        'description',
        'PropertySchema',
        'description must be a String in PropertySchema',
      );
    }
    if (!(json['optional'] is bool) && !(json['optional'] == null)) {
      throw CheckedFromJsonException(
        json,
        'optional',
        'PropertySchema',
        'optional must be a bool or null in PropertySchema',
      );
    }

    return PropertySchema(
      type: json['type'],
      description: json['description'],
      optional: json['optional'],
    );
  }

  final String type;
  final String description;
  final bool optional;
}
