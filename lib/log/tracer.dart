import 'dart:developer';

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_flutter_lib/log/trace_record.dart';

final _log = <TraceRecord>[];

enum TraceLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf;
}

void trace(String tag, String msg, {StackTrace? stackTrace, TraceLevel level = TraceLevel.verbose}) {
  if (level == TraceLevel.debug && !kDebugMode) {
    return;
  }

  final record = TraceRecord(
    level: level,
    message: msg,
    tag: tag,
    time: DateTime.now(),
  );
  _log.add(record);

  final prefix = switch (level) {
    TraceLevel.debug => '[DEBUG]',
    TraceLevel.error => '[ERROR]',
    TraceLevel.info => '[INFO]',
    TraceLevel.verbose => '[VERBOSE]',
    TraceLevel.warning => '[WARNING]',
    TraceLevel.wtf => '[WTF]',
  };

  final output = '$prefix ${record.time} [$tag] => $msg';
  final ansi = switch (level) {
    TraceLevel.verbose => AnsiPen()..gray(level: 0.5),
    TraceLevel.debug => AnsiPen()..white(bold: true),
    TraceLevel.info => AnsiPen()..rgb(r: 0.2, g: 0.6, b: 1.0),
    TraceLevel.warning => AnsiPen()..rgb(r: 1.0, g: 0.6, b: 0.0),
    TraceLevel.error => AnsiPen()..rgb(r: 1.0, g: 0.3, b: 0.3),
    TraceLevel.wtf => AnsiPen()..rgb(r: 1.0, g: 0.4, b: 1.0),
  };

  if (kIsWeb && kDebugMode) {
    // ignore: avoid_print
    print(output);
  } else {
    log(
      ansi(output),
      time: record.time,
      stackTrace: stackTrace,
    );
  }
}

void wtf(String msg, {String? tag}) => trace(tag ?? 'WTF', msg, level: TraceLevel.wtf);

final class Tracer {
  List<TraceRecord> get log => _log.sublist(0);
}
