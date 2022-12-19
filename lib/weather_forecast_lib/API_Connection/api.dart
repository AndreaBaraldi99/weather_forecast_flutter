import 'package:http/http.dart' as http;
import 'package:weather_forecast/weather_forecast_lib/API_Connection/api_response.dart';

class API {
  Future<ApiResponse> callAPI(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return ApiResponse(
            responseBody: response.body, responseCode: response.statusCode);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load response');
      }
    } on Exception catch (e) {
      return ApiResponse(responseBody: e.toString(), responseCode: 0);
    }
  }
}
