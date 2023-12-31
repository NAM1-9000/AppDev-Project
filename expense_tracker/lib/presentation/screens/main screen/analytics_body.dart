import 'package:expense_tracker/business%20logic/cubits/add_entry/add_entry_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fl_chart/fl_chart.dart';

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({Key? key}) : super(key: key);

  @override
  _AnalyticsBodyState createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody> {
  late List<EntryModel> entries;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('analytics'));
    //BlocBuilder<AuthCubit, AuthState>(
    //     builder: (context, state) {
    //       if (state is AuthSuccess) {
    //         return BlocConsumer<AddEntryCubit, AddEntryState>(
    //           listener: (context, state) {},
    //           builder: (context, state) {
    //             if (state is AddEntrySuccess) {
    //               entries = state.userModel.entries;
    //             }

    //             return _buildPieChart(entries);
    //           },
    //         );
    //       } else {
    //         return const CircularProgressIndicator();
    //       }
    //     },
    //   );
    // }

    // Widget _buildPieChart(List<EntryModel> entries) {
    //   Map<String, double> categoryMap = {};

    //   // Calculate total amount for each category
    //   for (EntryModel entry in entries) {
    //     if (categoryMap.containsKey(entry.category)) {
    //       categoryMap[entry.category]! += entry.amount;
    //     } else {
    //       categoryMap[entry.category] = entry.amount;
    //     }
    //   }

    //   // Convert data for pie chart
    //   List<PieChartSectionData> sections = [];
    //   int index = 0;
    //   categoryMap.forEach((category, amount) {
    //     sections.add(
    //       PieChartSectionData(
    //         color: FlColors[index % FlColors.length],
    //         value: amount,
    //         title: '$category\n${amount.toStringAsFixed(2)}',
    //         radius: 50,
    //       ),
    //     );
    //     index++;
    //   });

    //   return Center(
    //     child: PieChart(
    //       PieChartData(
    //         sectionsSpace: 0,
    //         centerSpaceRadius: 40,
    //         sections: sections,
    //       ),
    //     ),
    //   );
  }
}
