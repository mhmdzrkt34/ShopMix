import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/chartsprovider/category_chart_provider.dart';
import 'package:shopmixadmin/chartsprovider/charts_orders_provider.dart';
import 'package:shopmixadmin/components/App_Bar_charts.dart';

import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:shopmixadmin/model_views/CategoryWithCount.dart';
import 'package:shopmixadmin/model_views/user_model_view.dart';
import 'package:shopmixadmin/models/order.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class dashboard extends StatelessWidget {
  dashboard({super.key});
  late double _deviceHight;
  late double _deviceWidth;

  late BuildContext _context;
  // List<_SalesData> data = [
  //   _SalesData('Jan', 35),
  //   _SalesData('Feb', 28),
  //   _SalesData('Mar', 34),
  //   _SalesData('Apr', 32),
  //   _SalesData('May', 40)
  // ];
  @override
  Widget build(BuildContext context) {
    _context = context;

    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<CategoriesWithCountprovider>(),
        ),
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<UserModelView>(),
        ),
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<Ordersmodelview>(),
        ),
      ],
      child: DefaultTabController(
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
        ),
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
          _orderselctor(),
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

  Selector<Ordersmodelview, List<order>?> _orderselctor() {
    return Selector<Ordersmodelview, List<order>?>(
      selector: (context, provider) => provider.orders,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _chart(value);
      },
    );
  }

  Widget _chart(List<order>? value) {
    if (value == null) {
      return const CircularProgressIndicator();
    }
    int i = 0;
    List<_SalesData> data = [];
    for (order ordr in value) {
      i++;
      data.add(
          _SalesData(ordr.totalPrice.toString(), ordr.quantity.toDouble()));
    }
    print('Data length: ${data.length}');
    print("count: " + i.toString());
    return Column(
      children: [
        SizedBox(
          width: _deviceWidth * 1,
          height: _deviceHight * 0.3,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: const ChartTitle(text: 'Users Ordares  analysis'),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Orders',
                dataLabelSettings: const DataLabelSettings(isVisible: true),
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
            dataCount: data.length,
            xValueMapper: (int index) {
              if (index >= 0 && index < data.length) {
                return data[index].year;
              }
              return null;
            },
            yValueMapper: (int index) {
              if (index >= 0 && index < data.length) {
                return data[index].sales;
              }
              return 0;
            },
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
          _categoryselctor(),
        ],
      ),
    );
  }

  Widget _chart2(List<CategoryWithCount>? categories) {
    if (categories == null || categories.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    int totalCount = categories.fold(0, (sum, element) => sum + element.count);

    final List<ChartData> chartData = [];

    for (CategoryWithCount element in categories) {
      double percentage = element.count / totalCount * 100;
      chartData.add(ChartData(element.Category.name, percentage));
    }

    final Map<String, ChartData> allChartData = {};
    for (CategoryWithCount element in categories) {
      allChartData[element.Category.name] =
          ChartData(element.Category.name, 0.0);
      if (element.count > 0) {
        allChartData[element.Category.name] =
            ChartData(element.Category.name, element.count / totalCount * 100);
      }
    }

    chartData.addAll(allChartData.values);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: _deviceHight * 0.3,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelMapper: (ChartData data, _) =>
                      '${data.x}: ${data.y.toStringAsFixed(2)}%', // Customize the label as per your requirement
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelPosition: ChartDataLabelPosition.outside,
                    connectorLineSettings: ConnectorLineSettings(
                      type: ConnectorType.curve,
                    ),
                    textStyle: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  explode: true,
                  explodeIndex: getExplodeIndex(chartData),
                  explodeOffset: '10%',
                  explodeAll: true,
                  radius: '80%',
                  enableTooltip: true,
                  groupMode: CircularChartGroupMode.point,
                  // groupTo: categories.length.toDouble(),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories[index].Category.name),
                subtitle: Text('Count: ${categories[index].count}'),
              );
            },
          ),
        ],
      ),
    );
  }

  int getExplodeIndex(List<ChartData> chartData) {
    double maxValue = 0;
    int explodeIndex = 0;
    for (int i = 0; i < chartData.length; i++) {
      if (chartData[i].y > maxValue) {
        maxValue = chartData[i].y;
        explodeIndex = i;
      }
    }
    return explodeIndex;
  }

  Selector<CategoriesWithCountprovider, List<CategoryWithCount>?>
      _categoryselctor() {
    return Selector<CategoriesWithCountprovider, List<CategoryWithCount>?>(
      selector: (context, provider) => provider.categoriesWithCount,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _chart2(value);
      },
    );
  }

  Widget _maincolumn3() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _logofather(),
          _Usersselctor(),
        ],
      ),
    );
  }

  Selector<UserModelView, Map<String, int>> _Usersselctor() {
    return Selector<UserModelView, Map<String, int>>(
      selector: (context, provider) => provider.getUserCountByCountry(),
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        return _chart3(value);
      },
    );
  }

  Widget _chart3(Map<String, int> UserCountByCountry) {
    if (UserCountByCountry.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final List<ChartData1> chartData1 = [];

    UserCountByCountry.forEach((countryCode, userCount) {
      chartData1.add(ChartData1(countryCode, userCount.toDouble()));
    });

    return Column(
      children: [
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<ChartData1, String>(
                  dataSource: chartData1,
                  xValueMapper: (ChartData1 data, _) => data.x,
                  yValueMapper: (ChartData1 data, _) => data.y),
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
  ChartData1(this.x, this.y);
  final String x;
  final double? y;
}
