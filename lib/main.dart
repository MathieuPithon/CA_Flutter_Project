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
      home: PlacesListPage(),
    );
  }
}
