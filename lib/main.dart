import 'package:carnet_voyage/screens/date_list.dart';
import 'package:carnet_voyage/screens/home_page.dart';
import 'package:carnet_voyage/screens/places_list_page.dart';
import 'package:carnet_voyage/screens/planning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/places_cubit.dart';
import 'model/place.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PlaceAdapter());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => PlacesCubit()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().loadPlaces();
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        primarySwatch: Colors.amber,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    const PlacesListPage(),
    const PlanningPage(),
    const DateList(
      totalDaysInMonth: 30,
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
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.amber,
            ),
            activeIcon: Icon(Icons.home_filled, color: Colors.amber),
            label: 'home_page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.place, color: Colors.amber),
            label: 'places_list_page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.calendar_view_day, color: Colors.amber),
            label: 'planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined, color: Colors.amber),
            activeIcon: Icon(Icons.calendar_month, color: Colors.amber),
            label: 'date_list',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
