import 'dart:developer';
import 'package:carnet_voyage/blocs/places_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/place.dart';

class PlaceCubit extends Cubit<PlacesState> {
  PlaceCubit() : super(PlacesState.loading());

  Future<void> loadMovie(int movieId) async {
    try {
      emit(PlacesState.loading());
      Place place = Place(
          0, "title", "address", ["photoPath"], "commentary", "wheater", 0);
      // final movie = await tmdbRepository.fetchMovie(movieId);
      emit(PlacesState.loaded([place]));
    } catch (e) {
      log(e.toString());
      emit(PlacesState.error());
    }
  }
}
