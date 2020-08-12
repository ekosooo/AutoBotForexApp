import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:forex_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfitChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barGroups: getBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: getPair,
              textStyle: TextStyle(
                color: kTextLightColor,
                fontSize: 18.w,
                fontFamily: "Nunito-Bold",
              ),
            ),
          ),
        ),
      ),
    );
  }

  getBarGroups() {
    List<double> barChartDatas = [
      300,
      250,
      350,
      150,
      70,
      89,
      149,
    ];
    List<BarChartGroupData> barChartGroups = [];
    barChartDatas.asMap().forEach(
          (i, value) => barChartGroups.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  y: value,
                  color: kPrimaryColor,
                  width: 30.w,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    color: Color(0xFFEBECEE),
                    y: 800.w,
                  ),
                ),
              ],
            ),
          ),
        );
    return barChartGroups;
  }

  String getPair(double value) {
    switch (value.toInt()) {
      case 0:
        return 'EUR/USD';
      case 1:
        return 'USD/JPY';
      case 2:
        return 'GBP/USD';
      case 3:
        return 'USD/CHF';
      case 4:
        return 'USD/CAD';
      case 5:
        return 'AUD/USD';
      case 6:
        return 'NZD/USD';
      default:
        return '';
    }
  }
}
