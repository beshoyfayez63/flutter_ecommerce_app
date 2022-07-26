import 'package:amazone_clone/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class CategoryProdctsChart extends StatelessWidget {
  final List<chart.Series<Sales, String>> seriesList;
  const CategoryProdctsChart({
    required this.seriesList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(seriesList);
  }
}
