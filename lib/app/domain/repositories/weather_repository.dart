import '../../data/models/network_response.dart';
import '../../services/api_clients.dart';
import '../../services/api_endpoints.dart';

class WeatherRepository {
  static Future<NetworkResponse> fetchWeather(String cityName) async {
    return await ApiClient().getRequest(ApiEndPoints.weatherByCity(cityName));
  }
}
