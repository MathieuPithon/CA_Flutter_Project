import 'package:carnet_voyage/blocs/places_cubit.dart';
import 'package:carnet_voyage/screens/places_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../model/place.dart';
import '../repositories/places_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _commentaryController = TextEditingController();
  final TextEditingController _wheaterController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout place")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Enter title'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(hintText: 'Enter address'),
            ),
            TextField(
              controller: _commentaryController,
              decoration: const InputDecoration(hintText: 'Enter commentary'),
            ),
            TextField(
              controller: _wheaterController,
              decoration: const InputDecoration(hintText: 'Enter wheater'),
            ),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(hintText: 'Enter rating'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty &&
                    _addressController.text.isNotEmpty &&
                    _commentaryController.text.isNotEmpty &&
                    _wheaterController.text.isNotEmpty &&
                    _ratingController.text.isNotEmpty) {
                  
                  Place place = Place(
                      uuid.v1(),
                      _titleController.text,
                      _addressController.text,
                      [], // remplacer par une logique appropriée pour gérer les chemins de photo
                      _commentaryController.text,
                      _wheaterController.text,
                      num.parse(_ratingController.text));

                  await context.read<PlacesCubit>().savePlace(place);

                  // Clear all fields
                  _titleController.clear();
                  _addressController.clear();
                  _commentaryController.clear();
                  _wheaterController.clear();
                  _ratingController.clear();
                }
              },
              child: const Text('Save Place'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlacesListPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _commentaryController.dispose();
    _wheaterController.dispose();
    _ratingController.dispose();
    super.dispose();
  }
}
