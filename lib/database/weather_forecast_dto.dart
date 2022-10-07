class WeatherRequest {
  final int? id;
  final String date;
  final int responseCode;
  final String responseBody;

  WeatherRequest(
      {this.id,
      required this.date,
      required this.responseCode,
      required this.responseBody});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'responseCode': responseCode,
      'responseBody': responseBody
    };
  }

  @override
  String toString() {
    return 'WeatherRequest{id: $id, date: $date, responseCode: $responseCode, responseBody: $responseBody}';
  }
}
