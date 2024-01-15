import 'dart:convert';

import '../../../../core/utils/extensions/date_extension.dart';
import '../../../../core/utils/extensions/double_extension.dart';
import '../../domain/entities/floor_entity.dart';

class FloorEntityMapper {
  static FloorEntity fromMap(Map<String, dynamic> map) {
    List timestampListMap = map['timestamp'];
    List valuesListMap = map['indicators']['quote'].first['open'];

    return FloorEntity(
      dates: DateExtension.parseTimestampListToDateTimeList(timestampListMap),
      values: DoubleExtension.convertDoubleListMapToDoubleList(valuesListMap),
    );
  }

  static FloorEntity fromJSON(String source) => fromMap(json.decode(source));
}
