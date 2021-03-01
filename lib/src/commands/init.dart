import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:scribes/src/logger.dart';

class InitCommand extends Command<void> {
  InitCommand({Logger logger}) : _logger = logger;

  final Logger _logger;

  @override
  String get description =>
      'Initializes example objects in the objects folder.';

  @override
  String get name => 'init';

  @override
  void run() {
    _logger..info('Initializing new Scribe objects...');

    File('objects/example.objects.yaml').createSync(recursive: true);
    File('objects/example.objects.yaml').writeAsStringSync('''
Car:
  description: A car that can be registered to drive.
  properties:
  - Registered:
      type: boolean
      description: True if this car is registered to an owner.
  - Owner:
      type: person
      optional: true
      description: The owner of this car if it is registered.
  - Color:
      type: car color
      description: The color of the majoritiy of the exterior of the car.
  - other registered drivers:
      type: list of person
      description: The other drivers registered to drive this car.

Person:
  description: A person that can be licensed to drive.
  properties:
  - first name:
      type: string
      description: The first name of the person.
  - last name:
      type: string
      description: The last name of the person.

Car Color:
  description: A color that the majority of a car is colored.
  type: enum
  enumValues:
  - val: Blue
    description: A blue car.
  - val: Red
    description: A red car.
  - val: Black
    description: A black car.
''');

    _logger
      ..info('')
      ..success('Genenerated example objects at objects/example.objects.yaml')
      ..success('Check them out then run:')
      ..info('')
      ..info('\$ scribe transcribe')
      ..info('')
      ..success('To generate dart and typescript files.');
  }
}
