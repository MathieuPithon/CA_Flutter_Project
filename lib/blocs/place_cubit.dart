// import 'dart:developer';

// import 'package:carnet_voyage/model/place.dart';

// class PlaceCubit extends Place {
//   PlaceCubit() : super(Place(0, title, address, photoPath, commentary, wheater, rating));

//   Future<void> loadMovie(int movieId) async {
//     try {
//       emit(MovieState.loading());
//       final movie = await tmdbRepository.fetchMovie(movieId);
//       emit(MovieState.loaded(movie));
//     } catch (e) {
//       log(e.toString());
//       emit(MovieState.error());
//     }
//   }
// }
