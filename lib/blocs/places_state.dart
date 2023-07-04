import '../model/data_state.dart';
import '../model/place.dart';

class PlacesState {
  DataState dataState;
  List<Place> places;

  PlacesState(this.dataState, [this.places = const []]);

  factory PlacesState.loading() => PlacesState(DataState.loading);

  factory PlacesState.loaded(List<Place> places) =>
      PlacesState(DataState.loaded, places);

  factory PlacesState.error() => PlacesState(DataState.error);
}
