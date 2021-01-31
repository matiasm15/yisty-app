import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  static String ago(DateTime time) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (time == today) {
      return 'Hoy';
    } else if (time == yesterday) {
      return 'Ayer';
    } else if (time == tomorrow) {
      return 'Mañana';
    } else {
      final String agoFormat = timeago.format(time, locale: 'es');

      return '${agoFormat[0].toUpperCase()}${agoFormat.substring(1)}';
    }
  }
}