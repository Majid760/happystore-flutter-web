import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            height: 200,
            child: Stack(children: [
              PieChart(PieChartData(sections: [
                PieChartSectionData(value: 15),
                PieChartSectionData(value: 23, color: Colors.orangeAccent),
                PieChartSectionData(
                  value: 45,
                  color: Colors.green,
                ),
                PieChartSectionData(value: 68, color: Colors.blue),
              ])),
              Positioned.fill(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    '234',
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  AutoSizeText('34')
                ],
              ))
            ])));
  }
}
