import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // pour le formatage des dates

class InfiniteScrollCalendar extends StatefulWidget {
  const InfiniteScrollCalendar({Key? key}) : super(key: key);

  @override
  _InfiniteScrollCalendarState createState() => _InfiniteScrollCalendarState();
}

class _InfiniteScrollCalendarState extends State<InfiniteScrollCalendar> {
  final _controller = ScrollController();
  final DateTime _currentDate = DateTime.now();
  int _currentMonth = DateTime.now().month;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemBuilder: (context, index) {
        // Obtenir le jour et le mois pour l'index actuel
        final date = _currentDate.add(Duration(days: index));
        final month = date.month;

        // Si nous sommes dans un nouveau mois, affichez une carte de mois avant la carte de jour
        if (month != _currentMonth) {
          _currentMonth = month;
          return Column(
            children: <Widget>[
              MonthCard(date),
              DayCard(date),
            ],
          );
        } else {
          return DayCard(date);
        }
      },
    );
  }
}

class MonthCard extends StatelessWidget {
  final DateTime date;

  const MonthCard(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMMM yyyy');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(formatter.format(date), style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime date;

  const DayCard(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    return Card(
      child: ListTile(
        title: Text(formatter.format(date)),
      ),
    );
  }
}