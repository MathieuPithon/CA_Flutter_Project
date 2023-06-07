class Place {
  final int id;
  final String title;
  final String address;
  final List<String> photoPath;
  final String commentary;
  final String wheater;
  final num rating;

  Place(this.id, this.title, this.address, this.photoPath, this.commentary,
      this.wheater, this.rating);

  factory Place.fromJson(Map<String, dynamic> json) => Place(
      json['id'],
      json['title'],
      json['address'],
      json['photoPath'],
      json['commentary'],
      json['wheater'],
      json['rating']);
}
