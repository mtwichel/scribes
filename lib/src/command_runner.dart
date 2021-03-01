import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'commands/commands.dart';
import 'logger.dart';
import 'version.dart';

/// {@template scribe_command_runner}
/// A [CommandRunner] for the Scribe CLI.
/// {@endtemplate}
class ScribeCommandRunner extends CommandRunner<void> {
  /// {@macro scribe_command_runner}
  ScribeCommandRunner({Logger logger})
      : _logger = logger ?? Logger(),
        super('scribe', '✍️ scribe \u{2022} translate your objects!') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
    addCommand(GenerateCommand(logger: _logger));
    addCommand(InitCommand(logger: _logger));
  }

  final Logger _logger;

  @override
  Future<void> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      _logger.info('scribe version: $packageVersion');
    }
    return super.runCommand(topLevelResults);
  }
}
