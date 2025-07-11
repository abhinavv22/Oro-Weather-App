import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class WeathterService {
  Future<Map<String, dynamic>?> fetchWeather(String cityName) async {
    final String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
    final String API_KEY = "1bd8c5128acb965d3de1dfd365f8e6be";

    final String COMPLETE_ENDPOINT_URL =
        '$BASE_URL?q=$cityName&appid=$API_KEY&units=metric';

    final weatherResponse = await http.get(Uri.parse(COMPLETE_ENDPOINT_URL));

    if (weatherResponse.statusCode == 200) {
      var decodedResponse = jsonDecode(weatherResponse.body);
      debugPrint("Decoded Response:$decodedResponse");
      return decodedResponse;
    }
  }
}
