import 'package:carnet_voyage/blocs/places_cubit.dart';
import 'package:carnet_voyage/screens/places_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../model/place.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  Place? place;
  int? index;

  HomePage({Key? key, this.place, this.index}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? _id;
  late TextEditingController _titleController;
  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _commentaryController = TextEditingController();
  late TextEditingController _wheaterController = TextEditingController();
  late TextEditingController _ratingController = TextEditingController();
  var uuid = const Uuid();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _id = widget.place?.id;
    _titleController = TextEditingController(text: widget.place?.title);
    _addressController = TextEditingController(text: widget.place?.address);
    _commentaryController =
        TextEditingController(text: widget.place?.commentary);
    _wheaterController = TextEditingController(text: widget.place?.wheater);
    _ratingController =
        TextEditingController(text: widget.place?.rating.toString());
  }

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
              decoration: const InputDecoration(
                hintText: 'Enter title',
              ),
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
            const SizedBox(height: 20),
            Text(
              "Date:${DateFormat('dd-MM-yyyy').format(selectedDate)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Choisir une date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_titleController.text != "" &&
                    _addressController.text != "" &&
                    _commentaryController.text != "" &&
                    _wheaterController.text != "" &&
                    _ratingController.text != "") {
                  Place place = Place(
                      _id != null? _id.toString() : uuid.v1(),
                      _titleController.text,
                      _addressController.text,
                      [],
                      _commentaryController.text,
                      _wheaterController.text,
                      num.parse(_ratingController.text),
                      selectedDate);

                  widget.place != null
                      ? context.read<PlacesCubit>().editPlace(place)
                      : await context.read<PlacesCubit>().savePlace(place);
                  _titleController.clear();
                  _addressController.clear();
                  _commentaryController.clear();
                  _wheaterController.clear();
                  _ratingController.clear();
                  Navigator.pop(context, true);
                } else {
                  null;
                }
              },
              child: const Text('Save Place'),
            ),
            if (widget.place != null)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<PlacesCubit>().deletePlace(widget.place!.id);
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlacesListPage()),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
