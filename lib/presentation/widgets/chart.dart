import 'package:banking_app_ui/config/config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  double aspectRatio;

  LineChartSample2({super.key, required this.aspectRatio});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.green,
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: LineChart(
            mainData(),
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 14,
      color: Colors.grey,
    );
    Widget text;
    switch (value) {
      case 1:
      case 5:
      case 8:
      case 11:
      case 15:
      case 20:
      case 25:
      case 29:
        text = Text('$value', style: style);
        break;

      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      titlesData: FlTitlesData(
        show: (widget.aspectRatio == 2),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      gridData: const FlGridData(show: false),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 30,
      rangeAnnotations: RangeAnnotations(horizontalRangeAnnotations: [
        HorizontalRangeAnnotation(
            y1: -6,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.08))
                  .toList(),
            ),
            y2: 0)
      ]),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 25),
            FlSpot(3, 15),
            FlSpot(5, 5),
            FlSpot(7, 3.1),
            FlSpot(8, 4),
            FlSpot(9, 19),
            FlSpot(11, 24),
            FlSpot(15, 12),
            FlSpot(20, 19),
            FlSpot(25, 29),
            FlSpot(30, 15),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.08))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
