import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_entity.dart';

class GraphicForecastWidget extends StatelessWidget {
  final List<HourlyEntity> hourlyData;

  const GraphicForecastWidget({
    super.key,
    required this.hourlyData,
  });

  double _getMinY(List<HourlyEntity> data) {
    double minTemp = double.infinity;

    for (var hour in data) {
      if (hour.minTemp < minTemp) minTemp = hour.minTemp;
    }

    minTemp = (minTemp ~/ 5) * 5;

    return minTemp;
  }

  double _getMaxY(List<HourlyEntity> data) {
    double maxTemp = double.negativeInfinity;

    for (var hour in data) {
      if (hour.maxTemp > maxTemp) maxTemp = hour.minTemp;
    }

    maxTemp = maxTemp + 5 - (maxTemp % 5);

    return maxTemp;
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> maxTempSpots = [];
    List<FlSpot> minTempSpots = [];
    for (HourlyEntity hour in hourlyData) {
      maxTempSpots
          .add(FlSpot(hourlyData.indexOf(hour).toDouble(), hour.maxTemp));
      minTempSpots
          .add(FlSpot(hourlyData.indexOf(hour).toDouble(), hour.minTemp));
    }

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  axisSide: AxisSide.left,
                  child: Text(
                    value.round().toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  // reservedSize: 40,
                  showTitles: true,
                  interval: 2,
                  getTitlesWidget: (value, meta) {
                    final int substringStartPosition =
                        hourlyData[value.toInt()].date.length - 9;
                    final String label = hourlyData[value.toInt()]
                        .date
                        .substring(
                            substringStartPosition, substringStartPosition + 6);

                    return SideTitleWidget(
                      axisSide: AxisSide.left,
                      child: Text(
                        label,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 10.0),
                      ),
                    );
                  }),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Constants.kBackgroundColor,
              width: 1,
            ),
          ),
          minY: _getMinY(hourlyData),
          maxY: _getMaxY(hourlyData),
          lineBarsData: [
            LineChartBarData(
              dotData: const FlDotData(show: false),
              spots: maxTempSpots,
              isCurved: true,
              color: Constants.kMaxHotTemp,
              belowBarData: BarAreaData(
                show: true,
                color: Constants.kMaxHotTemp,
              ),
              isStrokeCapRound: true,
            ),
            LineChartBarData(
              dotData: const FlDotData(show: false),
              spots: minTempSpots,
              isCurved: true,
              color: Constants.kMinHotTemp,
              belowBarData: BarAreaData(
                show: true,
                color: Constants.kMinHotTemp,
              ),
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}
