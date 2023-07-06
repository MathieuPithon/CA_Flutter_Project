import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';  // pour le formatage des dates
import 'package:intl/date_symbol_data_local.dart';

import '../blocs/places_cubit.dart';
import '../model/place.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({Key? key}) : super(key: key);

  @override
  _PlanningPageState createState() => _PlanningPageState();
}


class _PlanningPageState extends State<PlanningPage> {
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
    final month = DateFormat.LLLL('fr_FR');
    final year = DateFormat('yyyy');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${month.format(date)} ${year.format(date)}", style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}

class DayCard extends StatelessWidget {
  final DateTime date;

  const DayCard(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    final day = DateFormat.EEEE('fr_FR');
    final day_number = DateFormat('dd');
    final month = DateFormat.LLLL('fr_FR');
    final year = DateFormat('yyyy');
    return Card(
      child: BlocBuilder<PlacesCubit, PlacesState>(
        builder: (context, places) {
          final todaysEvents = context.read<PlacesCubit>().getEventsForDay(date);
          return Column(
            children: [
              ListTile(
                title: Text("${day.format(date)} ${day_number.format(date)} ${month.format(date)} ${year.format(date)}"),
              ),
              ...todaysEvents.map((place) =>
                ListTile(
                  title: Text(place.title),
                )
              ).toList(),
            ],
          );
        },
      ),
    );
  }
}