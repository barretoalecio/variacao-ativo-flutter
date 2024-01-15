import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static List<DateTime> parseTimestampListToDateTimeList(
    List timestampsListMap,
  ) {
    List<int> timestamps = List.castFrom<dynamic, int>(timestampsListMap);

    return timestamps.map((timestamp) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }).toList();
  }

  String formattedToBrazilDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
