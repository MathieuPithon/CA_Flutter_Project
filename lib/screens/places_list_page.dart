import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/places_cubit.dart';
import '../blocs/places_state.dart';
import '../model/data_state.dart';
import 'home_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlacesListPage extends StatefulWidget {
  const PlacesListPage({super.key});

  @override
  _PlacesListPageState createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  TextEditingController _searchController = TextEditingController();
  String filter = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        filter = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Places')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Rechercher'),
            ),
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
                  var filteredPlaces = state.places
                      .where((place) => place.title.contains(filter))
                      .toList();
                  return ListView.builder(
                    itemCount: filteredPlaces.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(filteredPlaces[index].title),
                          subtitle: Text(filteredPlaces[index].address),
                          trailing: RatingBarIndicator(
                            rating: filteredPlaces[index].rating.toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  place: filteredPlaces[index],
                                  index: index,
                                ),
                              ),
                            );
                            _searchController.clear();
                          },
                        ),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
