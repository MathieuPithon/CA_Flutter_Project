import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/places_cubit.dart';
import '../blocs/places_state.dart';
import '../model/data_state.dart';
import 'home_page.dart';

class PlacesListPage extends StatefulWidget {
  @override
  _PlacesListPageState createState() => _PlacesListPageState();
}

class _PlacesListPageState extends State<PlacesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Places')),
      body: BlocBuilder<PlacesCubit, PlacesState>(
        builder: (context, state) {
          if (state.dataState == DataState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.dataState == DataState.error) {
            return const Center(
                child: Text('Erreur lors du chargement des données'));
          } else {
            return ListView.builder(
              itemCount: state.places.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.places[index].title),
                    subtitle: Text(state.places[index].address),
                    onTap: () {
                      // await context
                      //     .read<PlacesCubit>()
                      //     .deletePlace(state.places[index].id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            place: state.places[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
