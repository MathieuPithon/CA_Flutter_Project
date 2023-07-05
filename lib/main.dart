import 'package:carnet_voyage/screens/places_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        primarySwatch: Colors.amber,
      ),
      home: const PlacesListPage(),
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
    const Screen1(),
    const Screen2(),
    const Screen3(),
    const Screen4(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Application'),
      ),
      body: _children[_currentIndex],  // affiche le screen actuel
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home_filled),
            label: 'home_page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            activeIcon: Icon(Icons.business_filled),
            label: 'places_list_page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            activeIcon: Icon(Icons.school_filled),
            label: 'planning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings_filled),
            label: 'date_list',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Screen1 extends StatefulWidget { HomePage 

  const Screen1({super.key});}
class Screen2 extends StatefulWidget {
  const Screen2({super.key});
 /* implémentez vos écrans ici */ }
class Screen3 extends StatefulWidget {
  const Screen3({super.key});
 /* implémentez vos écrans ici */ }
class Screen4 extends StatelessWidget {
  const Screen4({super.key});
 /* implémentez vos écrans ici */ }