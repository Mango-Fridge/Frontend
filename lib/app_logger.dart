import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger();

  static Logger get logger => _logger;
}
