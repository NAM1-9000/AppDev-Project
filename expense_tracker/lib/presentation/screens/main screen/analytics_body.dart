import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/pie_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({Key? key}) : super(key: key);

  @override
  _AnalyticsBodyState createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  late List<EntryModel> _chartData;

  //get data from firestore
  List<EntryModel> getChartData() {
    final List<EntryModel> chartData = [
      EntryModel(
          title: 'owinowec',
          amount: 1000,
          date: DateTime.now(),
          category: 'Food'),
      EntryModel(
          title: 'owinowec',
          amount: 2340,
          date: DateTime.now(),
          category: 'Groceries'),
      EntryModel(
          title: 'owinowec',
          amount: 987,
          date: DateTime.now(),
          category: 'Clothes'),
      EntryModel(
          title: 'owinowec',
          amount: 465,
          date: DateTime.now(),
          category: 'Food'),
      EntryModel(
          title: 'owinowec',
          amount: 412,
          date: DateTime.now(),
          category: 'Bills'),
      EntryModel(
          title: 'owinowec',
          amount: 894,
          date: DateTime.now(),
          category: 'Food'),
    ];
    return chartData;
  }

  // group into categories, and convert into PieChartData
  List<PieChartData> processData(List<EntryModel> data) {
    Map<String, double> categoryMap = {};

    for (EntryModel entry in data) {
      if (categoryMap.containsKey(entry.category)) {
        categoryMap[entry.category] =
            (categoryMap[entry.category] ?? 0) + entry.amount;
      } else {
        categoryMap[entry.category] = entry.amount;
      }
    }
    List<PieChartData> processedData = categoryMap.entries
        .map((entry) => PieChartData(category: entry.key, amount: entry.value))
        .toList();

    return processedData;
  }

  @override
  Widget build(BuildContext context) {
    List<EntryModel> rawData = getChartData();
    List<PieChartData> processedData = processData(rawData);

    return SafeArea(
      child: Scaffold(
        body: SfCircularChart(
          legend: Legend(isVisible: true),
          title: ChartTitle(
            text: 'Expenses By Category',
          ),
          tooltipBehavior: _tooltipBehavior,
          series: [
            PieSeries<PieChartData, String>(
              dataSource: processedData,
              xValueMapper: (PieChartData data, _) => data.category,
              yValueMapper: (PieChartData data, _) => data.amount,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true,
            )
          ],
        ),
      ),
    );
  }
}
