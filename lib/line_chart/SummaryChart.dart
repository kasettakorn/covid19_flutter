import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid19/models/Timeline.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SummaryChartState();
  }
}

class _SummaryChartState extends State<SummaryChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<Color> gradientDeathColor = [
    const Color(0xFFFF5252),
    const Color(0xFFD50000)
  ];

  bool showAvg = false;
  final String url = "https://covid19.th-stat.com/api/open/timeline";
  var data;
  bool _loading = true;
  List<ResTimeline> data7days;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    data = json.decode(response.body);
    data["Data"].removeRange(0, data["Data"].length - 7);

    setState(() {
      _loading = false;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return (!_loading)
        ? Container(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "กราฟผู้ติดเชื้อ วันที่ 6 เมษายน 2563 - 12 เมษายน 2563",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 21.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      mainData(),
                    ),
                  ),
                ),

                ///กราฟเสียชีวิต
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    "กราฟผู้เสียชีวิต วันที่ 6 เมษายน 2563 - 12 เมษายน 2563",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Color(0xff232d37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 21.0, left: 12.0, top: 24, bottom: 12),
                    child: LineChart(
                      deathsData(),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(color: Colors.white, child: CircularProgressIndicator());
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'อาทิตย์';
              case 2:
                return 'จันทร์';
              case 4:
                return 'อังคาร';
              case 6:
                return 'พุธ';
              case 8:
                return 'พฤหัสบดี';
              case 10:
                return 'ศุกร์';
              case 12:
                return 'เสาร์';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1500:
                return '1500';
              case 2000:
                return '2000';
              case 2500:
                return '2500';
              case 3000:
                return '3000';
              case 3500:
                return '3500';
              case 4000:
                return '4000';
              case 4500:
                return '4500';
            }
            return '';
          },
          reservedSize: 30,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 3)),
      minX: 0,
      maxX: 12,
      minY: 1000,
      maxY: 4000,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, double.parse(data["Data"][0]["Confirmed"].toString())),
            FlSpot(2, double.parse(data["Data"][1]["Confirmed"].toString())),
            FlSpot(4, double.parse(data["Data"][2]["Confirmed"].toString())),
            FlSpot(6, double.parse(data["Data"][3]["Confirmed"].toString())),
            FlSpot(8, double.parse(data["Data"][4]["Confirmed"].toString())),
            FlSpot(10, double.parse(data["Data"][5]["Confirmed"].toString())),
            FlSpot(12, double.parse(data["Data"][6]["Confirmed"].toString())),
          ],
          colors: gradientColors,
          barWidth: 4,
          dotData: FlDotData(show: true, strokeWidth: 1),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData deathsData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        /*drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 3,

          );
        },*/
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'อาทิตย์';
              case 2:
                return 'จันทร์';
              case 4:
                return 'อังคาร';
              case 6:
                return 'พุธ';
              case 8:
                return 'พฤหัสบดี';
              case 10:
                return 'ศุกร์';
              case 12:
                return 'เสาร์';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
              case 60:
                return '60';
              case 70:
                return '70';
            }
            return '';
          },
          reservedSize: 30,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 3)),
      minX: 0,
      maxX: 12,
      minY: 10,
      maxY: 70,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, double.parse(data["Data"][0]["Deaths"].toString())),
            FlSpot(2, double.parse(data["Data"][1]["Deaths"].toString())),
            FlSpot(4, double.parse(data["Data"][2]["Deaths"].toString())),
            FlSpot(6, double.parse(data["Data"][3]["Deaths"].toString())),
            FlSpot(8, double.parse(data["Data"][4]["Deaths"].toString())),
            FlSpot(10, double.parse(data["Data"][5]["Deaths"].toString())),
            FlSpot(12, double.parse(data["Data"][6]["Deaths"].toString())),
          ],
          colors: gradientDeathColor,
          barWidth: 4,
          dotData: FlDotData(show: true, strokeWidth: 1),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientDeathColor
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }
}
