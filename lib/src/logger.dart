import 'dart:io';
import 'package:io/ansi.dart';

/// A basic Logger which wraps [print] and applies various styles.
class Logger {
  /// Writes info message to stdout.
  void info(String message) => stdout.writeln(message);

  /// Writes error message to stdout.
  void err(String message) => stdout.writeln(lightRed.wrap(message));

  /// Writes alert message to stdout.
  void alert(String message) {
    stdout.writeln(lightCyan.wrap(styleBold.wrap(message)));
  }

  /// Writes warning message to stdout.
  void warn(String message) {
    stdout.writeln(yellow.wrap(styleBold.wrap('[WARN] $message')));
  }

  /// Writes success message to stdout.
  void success(String message) => stdout.writeln(lightGreen.wrap(message));

  /// Prompts user and returns response.
  String prompt(String message) {
    stdout.write('$message');
    return stdin.readLineSync();
  }
}
