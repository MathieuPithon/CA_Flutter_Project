import 'dart:io';

import 'package:carnet_voyage/blocs/places_cubit.dart';
import 'package:carnet_voyage/model/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../screens/place_detail_screen.dart';

class EventTile extends StatelessWidget {
  final Place event;
  const EventTile(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title),
      subtitle: event.photoPath.isNotEmpty
          ? Image.file(File(event.photoPath[0]))
          : null,
      trailing: RatingBarIndicator(
        rating: event.rating.toDouble(),
        itemBuilder: (context, index) =>
            const Icon(Icons.star, color: Colors.amber),
        itemCount: 5,
        itemSize: 20.0,
        direction: Axis.horizontal,
      ),
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              place: event,
            ),
          ),
        );
        if (result == true) {
          context.read<PlacesCubit>().loadPlaces();
        }
      },
    );
  }
}
