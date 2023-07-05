import 'dart:developer';
import 'package:carnet_voyage/blocs/places_state.dart';
import 'package:carnet_voyage/repositories/places_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/place.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(PlacesState.loading());
  List<Place> places = [];

  Future<void> loadPlaces() async {
    try {
      emit(PlacesState.loading());
      List<Place> places = await PlacesRepository.loadPlaces();
      emit(PlacesState.loaded(places));
    } catch (e) {
      log(e.toString());
      emit(PlacesState.error());
    }
  }

  Future<void> deletePlace(String id) async {
    try {
      await PlacesRepository.deletePlace(id);
      places.removeWhere((place) => place.id == id);
      emit(PlacesState.loaded(places));
    } catch (e) {
      log(e.toString());
      emit(PlacesState.error());
    }
  }

  Future<void> savePlace(Place place) async {
    try {
      emit(PlacesState.loading());
      places.add(place);
      await PlacesRepository.savePlace(place);
      emit(PlacesState.loaded(places));
    } catch (e) {
      log(e.toString());
      emit(PlacesState.error());
    }
  }

  Future<void> editPlace(int index, Place place) async {
    try {
      emit(PlacesState.loading());
      await PlacesRepository.editPlace(place);
      places[index] = place;
      emit(PlacesState.loaded(places));
    } catch (e) {
      log(e.toString());
      emit(PlacesState.error());
    }
  }
}
