import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/date_extension.dart';
import '../../../../core/utils/extensions/double_extension.dart';
import '../../domain/entities/floor_entity.dart';

class AssetFloorDataTable extends StatelessWidget {
  const AssetFloorDataTable({
    super.key,
    required this.floorEntity,
  });

  final FloorEntity floorEntity;

  final List<DataColumn> columns = const [
    DataColumn(label: Text('Dia')),
    DataColumn(label: Text('Data')),
    DataColumn(label: Text('Valor')),
    DataColumn(label: Text('Variação em relação a D-1')),
    DataColumn(label: Text('Variação em relação a primeira data')),
  ];

  DataRow generateDataRows(MapEntry<int, double> entry) {
    final DateTime currentDate = floorEntity.dates[entry.key];

    return DataRow(
      color: MaterialStateProperty.all<Color>(
        entry.key % 2 == 0 ? Colors.grey.shade200 : Colors.white,
      ),
      cells: [
        DataCell(Text((entry.key + 1).toString().padLeft(2, '0'))),
        DataCell(Text(currentDate.formattedToBrazilDate())),
        DataCell(Text(floorEntity.values[entry.key].toCurrency())),
        DataCell(
          Text(
            entry.key == 0
                ? '-'
                : '${floorEntity.values[entry.key].getDifferenceBeetweenDays(floorEntity.values[entry.key - 1]).toStringAsFixed(2)}%',
          ),
        ),
        DataCell(
          Text(
            entry.key == 0
                ? '-'
                : '${floorEntity.values[entry.key].getDifferenceBeetweenDays(floorEntity.values[0]).toStringAsFixed(2)}%',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowMinHeight: 20,
        dataRowMaxHeight: 30,
        columnSpacing: 30,
        columns: columns,
        rows: floorEntity.values.asMap().entries.map(generateDataRows).toList(),
      ),
    );
  }
}
