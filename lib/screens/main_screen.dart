import 'package:carnet_voyage/screens/date_list.dart';
import 'package:carnet_voyage/screens/home_page.dart';
import 'package:carnet_voyage/screens/places_list_page.dart';
import 'package:carnet_voyage/screens/planning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/places_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    // HomePage(),
    const PlacesListPage(),
    const PlanningPage(),
    const DateList(
      totalDaysInMonth: 35,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().loadPlaces();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carnet de Voyage'),
      ),
      body: _children[_currentIndex], // affiche le screen actuel
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        selectedFontSize: 14,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.home_outlined,
          //     color: Colors.amber,
          //   ),
          //   activeIcon: Icon(Icons.home_filled, color: Colors.amber),
          //   label: 'home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.place, color: Colors.amber),
            label: 'liste des endroits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.calendar_view_day, color: Colors.amber),
            label: 'planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.calendar_month, color: Colors.amber),
            label: 'liste des dates',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
