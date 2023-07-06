import 'package:hive/hive.dart';

part 'place.g.dart'; // Le nom du fichier d'adaptateur généré par Hive

@HiveType(
    typeId:
        0) // Déclare cette classe comme un type Hive et lui attribue un typeId unique
class Place {
  @HiveField(
      0) // Chaque champ est déclaré comme un champ Hive avec un index unique
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String address;

  @HiveField(3)
  List<String> photoPath;

  @HiveField(4)
  String commentary;

  @HiveField(5)
  String wheater;

  @HiveField(6)
  num rating;

  @HiveField(7)
  DateTime date;

  Place(this.id, this.title, this.address, this.photoPath, this.commentary,
      this.wheater, this.rating, this.date);
}
