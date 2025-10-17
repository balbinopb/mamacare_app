import 'package:logger/logger.dart';

/// Global logger instance
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Show method calls in stack trace
    errorMethodCount: 5, // Show more stack traces for errors
    lineLength: 80, // Wrap lines for better readability
    colors: true, // Enable colored logs
    printEmojis: true, // Show emojis for log levels
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);
