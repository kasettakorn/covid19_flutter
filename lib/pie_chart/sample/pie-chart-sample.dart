import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'indicator.dart';
import 'dart:convert';
class Pie_Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Pie_ChartState();
}

class Pie_ChartState extends State<Pie_Chart> {
  int touchedIndex;
  final String url = "https://covid19.th-stat.com/api/open/today";
  var data;
  int sum = 0;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    this.getJsonData();

  }
  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: (data != null) ? Container(
        child: Card(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections()),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Indicator(
                    color: Colors.blue,
                    text: 'ผู้ติดเชื้อ',
                    isSquare: true,
                    textColor: touchedIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.green[600],
                    text: 'รักษาหาย',
                    isSquare: true,
                    textColor: touchedIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Colors.red[400],
                    text: 'เสียชีวิต',
                    isSquare: true,
                    textColor: touchedIndex == 2 ? Colors.black : Colors.grey,
                  ),
                  SizedBox(
                    height: 4,
                  ),

                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ) : Container(),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: double.parse(data["Confirmed"].toString()),
            title: data["Confirmed"].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green[600],
            value: double.parse(data["Recovered"].toString()),
            title: data["Recovered"].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red[400],
            value: double.parse(data["Deaths"].toString()),
            title: data["Deaths"].toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          return null;
      }
    });
  }
}