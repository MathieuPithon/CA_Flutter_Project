import 'package:hive/hive.dart';

import '../model/place.dart';

class PlacesRepository {
  // Future<void> savePlaces(List<Place> places) async {
  //   var box = await Hive.openBox<Place>('Places');
  //   for (var place in places) {
  //     await box.add(place);
  //   }
  // }
  static Future<void> savePlace(Place place) async {
    var box = await Hive.openBox<Place>('Places');
    await box.put(place.id, place);

    box.close();
  }

  static Future<List<Place>> loadPlaces() async {
    print('ffffff');
    var box = await Hive.openBox<Place>('Places');
    List<Place> places = [];

    box.toMap().forEach((key, place) {
      places.add(place);
    });

    box.close();
    return places;
  }

  static Future<void> deletePlace(String id) async {
    var box = await Hive.openBox<Place>('Places');
    box.delete(id);
    box.close();
  }

static Future<void> editPlace(Place place) async {
  var box = await Hive.openBox<Place>('Places');
  box.put(place.id, place);  // remplace automatiquement la valeur existante
  box.close();
}
}
