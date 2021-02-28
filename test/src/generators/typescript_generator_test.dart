import 'package:scribe/scribe.dart';
import 'package:test/test.dart';

void main() {
  group('TypescriptGenerator', () {
    group('generate', () {
      test('generates correct code', () {
        final generator = TypeScriptGenerator();
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
                  Property(
                    name: 'Lug Nuts',
                    type: ListType(IntType()),
                    description: 'The number of lug nuts on each wheel.',
                    optional: true,
                  ),
                ],
              ),
            ],
          ),
          '''
export interface Car {
  /** The color of the exterior of the car. */
  color: string;

  /** The number of gears the cars has in its transmition. */
  gears: number;

  /** The top speed of the car in m per h. */
  topSpeed?: number;

  /** True if this car is registered to drive. */
  registered: boolean;

  /** The names of people registered to drive this vehicle. */
  registeredDrivers: string[];

  /** The number of lug nuts on each wheel. */
  lugNuts?: number[];

}

export function isACar(input: any): input is Car {
  return (
    input &&
    typeof input.color === "string" &&
    typeof input.gears === "number" &&
    (typeof input.topSpeed === "number" || !input.topSpeed) &&
    typeof input.registered === "boolean" &&
    Array.isArray(input.registeredDrivers) &&
    input.registeredDrivers.every((elem) => typeof elem === "string") &&
    (Array.isArray(input.lugNuts) &&
    input.lugNuts.every((elem) => typeof elem === "number") || !input.lugNuts)
  );
}
''',
        );
      });
    });
  });
}
