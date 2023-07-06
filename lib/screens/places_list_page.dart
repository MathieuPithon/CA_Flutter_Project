import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/places_cubit.dart';
import '../blocs/places_state.dart';
import '../model/data_state.dart';
import '../widgets/event_tile.dart';
import 'home_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  _PlacesListPageState createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  TextEditingController _searchController = TextEditingController();
  int _sortOption = 0; // 0 = date, 1 = rating, 2 = alphabétique

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Places')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Chercher par nom...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          DropdownButton(
            value: _sortOption,
            items: const [
              DropdownMenuItem(child: Text("Date"), value: 0),
              DropdownMenuItem(child: Text("Rating"), value: 1),
              DropdownMenuItem(child: Text("Alphabétique"), value: 2),
            ],
            onChanged: (int? newValue) {
              setState(() {
                _sortOption = newValue!;
              });
            },
          ),
          Expanded(
            child: BlocBuilder<PlacesCubit, PlacesState>(
              builder: (context, state) {
                if (state.dataState == DataState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.dataState == DataState.error) {
                  return const Center(
                      child: Text('Erreur lors du chargement des données'));
                } else {
                  var places = state.places
                      .where((place) => place.title
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();

                  if (_sortOption == 0) {
                    places.sort((a, b) => a.date.compareTo(b.date));
                  } else if (_sortOption == 1) {
                    places.sort((a, b) => b.rating.compareTo(a.rating));
                  } else if (_sortOption == 2) {
                    places.sort((a, b) => a.title.compareTo(b.title));
                  }

                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: EventTile(places[index])
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
