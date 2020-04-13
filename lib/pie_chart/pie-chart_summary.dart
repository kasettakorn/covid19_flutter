import 'package:flutter/material.dart';
import 'sample/pie-chart-sample.dart';

class PieChartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  'กราฟแสดงยอดสะสมสถานการณ์ Covid-19 ในประเทศไทย',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Pie_Chart(),
            const SizedBox(
              height: 12,
            ),

          ],
        ),
      ),
    );
  }
}