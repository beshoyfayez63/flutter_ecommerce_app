import 'package:amazone_clone/common/widgets/loading.dart';
import 'package:amazone_clone/features/admin/widgets/category_product_chart.dart';
import 'package:amazone_clone/models/sales.dart';
// import 'package:amazone_clone/features/admin/widgets/category_product_chart.dart';
// import 'package:amazone_clone/models/sales.dart';
import 'package:amazone_clone/providers/admin_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AdminProvider>(context, listen: false).getAnalytics(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          var data = (snapshot.data as Map<String, dynamic>);

          // return ;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                '\$${data['totalEarnings']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    widthFactor: 0.9,
                    alignment: Alignment.topCenter,
                    child: CategoryProdctsChart(
                      seriesList: [
                        charts.Series(
                          id: 'Sales',
                          data: data['sales'],
                          domainFn: (Sales sales, _) => sales.label,
                          measureFn: (Sales sales, _) => sales.earnings,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
