import 'package:json_annotation/json_annotation.dart';

class EnumValueSchema {
  EnumValueSchema({
    this.val,
    this.description,
  });

  factory EnumValueSchema.fromJson(Map json) {
    if (!(json['val'] is String)) {
      throw CheckedFromJsonException(
        json,
        'val',
        'EnumValueSchema',
        'val must be a String',
      );
    }
    if (!(json['description'] is String)) {
      throw CheckedFromJsonException(
        json,
        'description',
        'EnumValueSchema',
        'description must be a String',
      );
    }

    return EnumValueSchema(val: json['val'], description: json['description']);
  }

  final String val;
  final String description;
}
