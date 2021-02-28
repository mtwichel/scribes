/// {@template enum_value}
/// A discreate value in an enum object.
/// {@endtemplate}
class EnumValue {
  /// {@macro enum_value}
  EnumValue({
    this.val,
    this.description,
  });

  /// The value of this enum value.
  final String val;

  /// A brief description of this value.
  final String description;
}
