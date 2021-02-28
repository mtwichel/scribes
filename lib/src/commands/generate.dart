import 'dart:io';

import 'package:args/command_runner.dart';
import '../generators/generators.dart';
import '../logger.dart';
import '../model/model.dart';
import '../parser/parser.dart';

class GenerateCommand extends Command<void> {
  GenerateCommand({Logger logger})
      : _logger = logger,
        super() {
    argParser
      ..addFlag(
        'typescript',
        help: 'Generate typescript file.',
        defaultsTo: true,
      )
      ..addFlag(
        'dart',
        help: 'Generate dart file.',
        defaultsTo: true,
      )
      ..addOption(
        'objects',
        help: 'The path to your objects folder.',
        defaultsTo: 'objects',
      )
      ..addOption(
        'dart-path',
        help: 'The path where objects.g.dart should be written.',
        defaultsTo: '.',
      )
      ..addOption(
        'typescript-path',
        help: 'The path where objects.g.ts should be written.',
        defaultsTo: '.',
      );
  }

  final Logger _logger;

  @override
  String get description =>
      'Generates source code for the objects in your objects folder.';

  @override
  String get name => 'transcribe';

  @override
  void run() {
    _logger..info('Here we go!')..info('');
    var objects = <NamedObject>[];
    final directory = Directory(argResults['objects']);
    if (directory.existsSync()) {
      directory.listSync(recursive: true);
      final files = directory.listSync(recursive: true);
      for (final file in files) {
        if (file.uri.toString().endsWith('.objects.yaml')) {
          _logger.info('Reading ${file.uri}...');
          final schema = File.fromUri(file.uri).readAsStringSync();
          objects = [...objects, ...SchemaParser().parse(schema)];
        } else {
          _logger.warn(
            'Found file ${file.uri} that is not a .objects.yaml file.',
          );
        }
      }
      _logger..info('')..info('${objects.length} objects found.');
      final dartContent = DartGenerator().generate(objects);
      final typescriptContent = TypeScriptGenerator().generate(objects);

      if (argResults['dart']) {
        File('${argResults['dart-path']}/objects.g.dart')
            .createSync(recursive: true);
        File('${argResults['dart-path']}/objects.g.dart').writeAsStringSync(
          'import \'package:equatable/equatable.dart\';\n\n$dartContent',
        );
        _logger.success('Wrote ${argResults['dart-path']}/objects.g.dart');
      }
      if (argResults['typescript']) {
        File('${argResults['typescript-path']}/objects.g.ts')
            .createSync(recursive: true);
        File('${argResults['typescript-path']}/objects.g.ts')
            .writeAsStringSync(typescriptContent, flush: true);
        _logger..success('Wrote ${argResults['typescript-path']}/objects.g.ts');
      }
      _logger
        ..info('')
        ..success('And we\'re done!');
    } else {
      _logger..err('objects directory not found at ${argResults['objects']}');
    }
  }
}
