import 'package:shared_core_lib/log/tracer.dart';

final class TraceRecord {
  final String tag;
  final String message;
  final TraceLevel level;
  final DateTime time;

  TraceRecord({
    required this.tag,
    required this.message,
    required this.level,
    required this.time,
  });

  @override
  String toString() => 'TracerRecord(tag: $tag, message: $message, level: $level)';
}
