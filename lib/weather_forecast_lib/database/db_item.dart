class WeatherResponse {
  late int? id;
  final String dateTime;
  final String data;
  final String location;

  WeatherResponse(
      {this.id,
      required this.dateTime,
      required this.data,
      required this.location});

  Map<String, dynamic> toMap() {
    return {'id': id, 'dateTime': dateTime, 'data': data, 'location': location};
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Weather{id: $id, name: $dateTime, age: $data, location: $location}';
  }
}
