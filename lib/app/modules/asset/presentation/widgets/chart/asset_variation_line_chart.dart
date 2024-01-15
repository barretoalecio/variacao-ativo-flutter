import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/entities/floor_entity.dart';

class AssetVariationLineChart extends StatelessWidget {
  const AssetVariationLineChart({
    super.key,
    required this.floorEntity,
    required this.assetCode,
  });

  final String assetCode;
  final FloorEntity floorEntity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 500,
          child: SfCartesianChart(
            title: ChartTitle(
              text: assetCode,
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            primaryXAxis: const DateTimeAxis(
              labelIntersectAction: AxisLabelIntersectAction.rotate45,
            ),
            primaryYAxis: NumericAxis(
              numberFormat:
                  NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$'),
              minimum: floorEntity.values
                  .reduce((a, b) => a < b ? a : b), // Menor valor da lista
              maximum: floorEntity.values
                  .reduce((a, b) => a > b ? a : b), // Maior valor da lista
            ),
            series: <LineSeries<double, DateTime>>[
              LineSeries<double, DateTime>(
                dataSource: _generateChartData(floorEntity),
                xValueMapper: (double sales, int index) {
                  if (index >= 0 && index < floorEntity.dates.length) {
                    return floorEntity.dates[index];
                  }
                  return DateTime(2000, 1, 1);
                },
                yValueMapper: (double sales, _) => sales,
                markerSettings: const MarkerSettings(isVisible: true),
                name: 'Variação de Valores',
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                color: Theme.of(context).colorScheme.primary,
                width: 5,
              ),
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ),
      ),
    );
  }

  List<double> _generateChartData(FloorEntity floorEntity) {
    List<double> chartData = [];
    for (int i = 0; i < floorEntity.dates.length; i++) {
      chartData.add(floorEntity.values[i]);
    }
    return chartData;
  }
}
