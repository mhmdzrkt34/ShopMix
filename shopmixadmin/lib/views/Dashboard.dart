import 'package:flutter/material.dart';
import 'package:shopmixadmin/components/App_Bar_charts.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:shopmixadmin/components/logo/logo.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class dashboard extends StatelessWidget {
  dashboard({super.key});
  late double _deviceHight;
  late double _deviceWidth;
  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  final List<ChartData1> chartData1 = <ChartData1>[
    ChartData1('Germany', 128, 129, 101),
    ChartData1('Russia', 123, 92, 93),
    ChartData1('Norway', 107, 106, 90),
    ChartData1('USA', 87, 95, 71),
  ];
  late BuildContext _context;
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    _context = context;

    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    // return MultiProvider(
    // providers: [],
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AdminAppBarchart(_deviceHight, _deviceWidth, "Dashboard"),
        drawer: SideBar(context),

        body: TabBarView(
          children: [
            _maincolumn(),
            _maincolumn2(),
            _maincolumn3(),
          ],
        ),
        // ),
      ),
    );
  }

  Widget _maincolumn() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _logofather(),
          _chart(),
        ],
      ),
    );
  }

  Widget _logofather() {
    return Container(
      width: _deviceWidth,
      height: _deviceHight * 0.1,
      margin: EdgeInsets.only(top: _deviceHight * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo(_deviceHight * 0.05, _deviceWidth * 0.3, const Color(0xFF1A1A1A),
              20),
        ],
      ),
    );
  }

  Widget _chart() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Half yearly sales analysis'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfSparkLineChart.custom(
            trackball: const SparkChartTrackball(
              activationMode: SparkChartActivationMode.tap,
            ),
            marker: const SparkChartMarker(
              displayMode: SparkChartMarkerDisplayMode.all,
            ),
            labelDisplayMode: SparkChartLabelDisplayMode.all,
            xValueMapper: (int index) => data[index].year,
            yValueMapper: (int index) => data[index].sales,
            dataCount: 5,
          ),
        ),
      ],
    );
  }

  Widget _maincolumn2() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _logofather(),
          _chart2(),
        ],
      ),
    );
  }

  Widget _chart2() {
    return Column(
      children: [
        SfCircularChart(series: <CircularSeries>[
          PieSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              groupMode: CircularChartGroupMode.point,
              groupTo: 2)
        ])
      ],
    );
  }

  Widget _maincolumn3() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _logofather(),
          _chart3(),
        ],
      ),
    );
  }

  Widget _chart3() {
    return Column(
      children: [
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<ChartData1, String>(
                  dataSource: chartData1,
                  xValueMapper: (ChartData1 data, _) => data.x,
                  yValueMapper: (ChartData1 data, _) => data.y),
              ColumnSeries<ChartData1, String>(
                  dataSource: chartData1,
                  xValueMapper: (ChartData1 data, _) => data.x,
                  yValueMapper: (ChartData1 data, _) => data.y1),
              ColumnSeries<ChartData1, String>(
                  dataSource: chartData1,
                  xValueMapper: (ChartData1 data, _) => data.x,
                  yValueMapper: (ChartData1 data, _) => data.y2)
            ])
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class ChartData1 {
  ChartData1(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
