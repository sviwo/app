import 'package:intl/intl.dart';

class TimeUtil {
  TimeUtil._();

  static DateTime? parseDateTime(String? time, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (time == null) return null;
    return DateFormat(format).parse(time);
  }

  static DateTime? parseMicros(num? time) {
    if (time == null) return null;
    return DateTime.fromMicrosecondsSinceEpoch(time.toInt());
  }

  static DateTime? parseMillis(num? time) {
    if (time == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(time.toInt());
  }

  static DateTime? parseSecond(num? time) {
    if (time == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(time.toInt() * 1000);
  }

  static String? formatDateTime(DateTime? dateTime, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (dateTime == null) return null;
    return DateFormat(format).format(dateTime);
  }

  static String? formatMicros(num? time, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (time == null) return null;
    return DateFormat(format).format(DateTime.fromMicrosecondsSinceEpoch(time.toInt()));
  }

  static String? formatMillis(num? time, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (time == null) return null;
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(time.toInt()));
  }

  static String? formatSecond(num? time, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    if (time == null) return null;
    return formatMillis(time.toInt() * 1000, format: format);
  }

  static String? formatString(String? dateTime,
      {String fromFormat = 'yyyy-MM-dd HH:mm:ss', String toFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    if (dateTime == null) return null;
    return formatDateTime(parseDateTime(dateTime, format: fromFormat), format: toFormat);
  }
}
