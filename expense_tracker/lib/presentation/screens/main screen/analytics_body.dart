import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/entry/add_entry_cubit.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/pie_chart_data.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({Key? key}) : super(key: key);

  @override
  _AnalyticsBodyState createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  late List<EntryModel>? _chartData;
  late List<PieChartData> processedData = [];
  late UserModel _authenticatedUser;
  late List<EntryModel> _userEntries;

  //get moc from firestore
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
  void initState() {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final entryCubit = BlocProvider.of<AddEntryCubit>(context);

    // get auth cubit instance and check if state is AuthSuccess, which it will be since user is logged in
    if (authCubit.state is AuthSuccess) {
      _authenticatedUser = (authCubit.state as AuthSuccess).userModel;

      // print(_authenticatedUser);
    }

    if (entryCubit.state is AddEntryInitial) {
      entryCubit.asyncGetEntries(userEmail: _authenticatedUser.email);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EntryModel> rawData = getChartData();

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AddEntryCubit, AddEntryState>(
          builder: (context, state) {
            print('state in build: $state');
            if (state is AddEntriesLoaded) {
              _chartData = state.userEntries;

              processedData = processData(_chartData!);

              return SfCircularChart(
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                title: ChartTitle(
                  text: 'Expenses By Category',
                ),
                tooltipBehavior: _tooltipBehavior,
                series: [
                  PieSeries<PieChartData, String>(
                    dataSource: processedData, // processedData ?? [],
                    xValueMapper: (PieChartData data, _) => data.category,
                    yValueMapper: (PieChartData data, _) => data.amount,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                  )
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
