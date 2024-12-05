import 'package:get/get.dart';

import '../../../data/models/weather_model.dart';
import '../../../data/models/network_response.dart';
import '../../../domain/repositories/weather_repository.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final weather = Rx<WeatherModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchWeather("Dhaka");
  }

  Future<void> fetchWeather(String cityName) async {
    isLoading.value = true;
    try {
      final NetworkResponse response = await WeatherRepository.fetchWeather(cityName);
      if (response.isSuccess) {
        weather.value = weatherModelFromJson(response.jsonResponse!);
      } else {
        Get.snackbar("Error", response.message ?? "Failed to fetch weather data");
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
