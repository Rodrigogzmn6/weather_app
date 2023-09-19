import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_entity.dart';

class GraphicForecastWidget extends StatelessWidget {
  final List<HourlyEntity> hourlyForecast;
  const GraphicForecastWidget({super.key, required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> chartLimits = _getAxisLimits(hourlyForecast);

    return Text('graph');
    return LineChart(
      LineChartData(
        minX: chartLimits['minX'].toDouble(),
        maxX: chartLimits['maxX'].toDouble(),
        minY: chartLimits['minY'].toDouble(),
        maxY: chartLimits['maxY'].toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: _getSpots(hourlyForecast),
            isCurved: true,
            color: const Color(0xff4af699),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0x33ff5722),
            ),
            isStrokeCapRound: true,
          ),
        ],
      ),
    );
  }
}

Map<String, dynamic> _getAxisLimits(List<HourlyEntity> data) {
  double minY = double.infinity, maxY = double.negativeInfinity;
  DateTime minX = DateTime.now(), maxX = DateTime.utc(1, 1, 1, 0, 0, 0, 0);

  return {
    'minY': 0,
    'maxY': 10,
    'minX': 0,
    'maxX': 10,
  };
}

List<FlSpot> _getSpots(List<HourlyEntity> data) {
  return [];
}
