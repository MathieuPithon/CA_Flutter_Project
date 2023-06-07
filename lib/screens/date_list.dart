import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateList extends StatelessWidget {
  // Le nombre total des jours dans le mois
  final int totalDaysInMonth;

  DateList({required this.totalDaysInMonth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: totalDaysInMonth,
        itemBuilder: (context, index) {
          // Calcule la date du jour courant
          final date =
              DateTime(DateTime.now().year, DateTime.now().month, index + 1);
          final formattedDate = DateFormat('yyyy-MM-dd').format(date);
          return Column(
            children: [
              SizedBox(
                height: 50.0,
                child: Center(
                    child: Text(formattedDate,
                        style: TextStyle(color: Colors.green))),
              ),
              Divider(height: 3.0, color: Colors.green),
            ],
          );
        },
      ),
    );
  }
}
