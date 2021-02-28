import 'package:test/test.dart';
import 'package:scribe/scribe.dart';

void main() {
  group('DartGenerator', () {
    group('generate', () {
      test('generates correct code', () {
        final generator = DartGenerator();
        expect(
          generator.generate(
            [
              DataObject(
                name: 'car',
                description: 'A car that can drive on the road.',
                properties: [
                  Property(
                    name: 'color',
                    type: StringType(),
                    description: 'The color of the exterior of the car.',
                  ),
                  Property(
                    name: 'Gears',
                    type: IntType(),
                    description:
                        'The number of gears the cars has in its transmition.',
                  ),
                  Property(
                    name: 'top speed',
                    type: DoubleType(),
                    optional: true,
                    description: 'The top speed of the car in m per h.',
                  ),
                  Property(
                    name: 'registered',
                    type: BooleanType(),
                    description: 'True if this car is registered to drive.',
                  ),
                  Property(
                    name: 'registered drivers',
                    type: ListType(StringType()),
                    description:
                        'The names of people registered to drive this vehicle.',
                  ),
                ],
              ),
            ],
          ),
          '''
import 'package:equatable/equatable.dart';

class Car extends Equatable {
  const Car({
    this.color,
    this.gears,
    this.topSpeed,
    this.registered,
    this.registeredDrivers,
  });

  /// The color of the exterior of the car.
  final String color;

  /// The number of gears the cars has in its transmition.
  final int gears;

  /// The top speed of the car in m per h.
  final double topSpeed;

  /// True if this car is registered to drive.
  final bool registered;

  /// The names of people registered to drive this vehicle.
  final List<String> registeredDrivers;

  @override
  List<Object> get props => [
    color,
    gears,
    topSpeed,
    registered,
    registeredDrivers,
  ];

  Map<String, dynamic> toJson() => {
    'color': color,
    'gears': gears,
    'topSpeed': topSpeed,
    'registered': registered,
    'registeredDrivers': registeredDrivers,
  };
}
''',
        );
      });
    });
  });
}
