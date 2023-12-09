import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key, required this.graphData}) : super(key: key);
  final List graphData;

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  List<FlSpot> list = [];
  late List graphData;

  @override
  void initState() {
    super.initState();
    graphData = widget.graphData;
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.graphData.length; i++) {
      if (widget.graphData[i].toDouble() > 0) {
        list.add(FlSpot(
            i.toDouble(), ((widget.graphData[i] / 1000).toInt()).toDouble()));
      }
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: SizedBox(
          height: height * (400 / 804),
          width: width * (275 / 340),
          child: AspectRatio(
            aspectRatio: 0.75,
            child: LineChart(LineChartData(
              lineTouchData: const LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.white,
                ),
              ),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                leftTitles: AxisTitles(sideTitles: _leftTitles),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(
                border: Border.all(width: 2.0),
                show: true,
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: list,
                  dotData: const FlDotData(show: false),
                  color: const Color.fromARGB(255, 1, 104, 115),
                  belowBarData: BarAreaData(
                    show: true,
                    color:
                        const Color.fromARGB(255, 1, 104, 115).withOpacity(0.3),
                  ),
                )
              ],
            )),
          ),
        )));
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 0:
              text = '0';
              break;
            case 5:
              text = '1';
              break;
            case 10:
              text = '6';
              break;
            case 15:
              text = '12';
              break;
            case 20:
              text = '18';
              break;
            case 25:
              text = '24';
            case 29:
              text = '30';
              break;
          }

          return Text(
            text,
            style: const TextStyle(
                fontFamily: "productSansReg",
                fontWeight: FontWeight.w500,
                fontSize: 11),
          );
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        interval: 100,
        getTitlesWidget: (value, meta) {
          String text = value.toInt().round().toString();
          return Text(
            text,
            style: const TextStyle(
                fontFamily: "productSansReg",
                fontWeight: FontWeight.w500,
                fontSize: 11),
          );
        },
      );
}
