import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/models/weather_model.dart';
import '../../../data/models/network_response.dart';
import '../../../domain/repositories/weather_repository.dart';
//
// class HomeController extends GetxController {
//   final isLoading = false.obs;
//   final weather = Rx<WeatherModel?>(null);
//
//   final weatherBox = Hive.box<WeatherModel>('weatherBox');
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchWeather("Dhaka");
//     loadWeather();
//   }
//
//   Future<void> loadWeather() async {
//     if (weatherBox.isNotEmpty) {
//       // Load cached data if available
//       weather.value = weatherBox.values as WeatherModel;
//     } else {
//       await fetchWeather("Dhaka");
//     }
//   }
//
//   Future<void> fetchWeather(String cityName) async {
//     isLoading.value = true;
//
//     final NetworkResponse response =
//         await WeatherRepository.fetchWeather(cityName);
//     if (response.isSuccess) {
//       final fetchedWeather = weatherModelFromJson(response.jsonResponse!);
//
//       // Save to Hive for offline access
//       await weatherBox.clear(); // Clear old data
//       //await weatherBox.addAll(fetchedWeather as Iterable<WeatherModel>);
//
//       // Update the observable
//       weather.value = fetchedWeather;
//     } else {
//       Get.snackbar("Error", response.message ?? "Failed to fetch weather data");
//     }
//     isLoading.value = false;
//   }
// }
class HomeController extends GetxController {
  final isLoading = false.obs;
  final weather = Rx<WeatherModel?>(null);

  late Box<WeatherModel> weatherBox;

  @override
  void onInit() async {
    super.onInit();
    await initHive();  // Initialize and load the box
    fetchWeather("Dhaka");
    loadWeather();
  }

  Future<void> initHive() async {
    // Open the weather box and assign it to the weatherBox variable
    weatherBox = await Hive.openBox<WeatherModel>('weather');
  }

  Future<void> loadWeather() async {
    if (weatherBox.isNotEmpty) {
      // Load cached data if available
      weather.value = weatherBox.values.first;
    } else {
      await fetchWeather("Dhaka");
    }
  }

  Future<void> fetchWeather(String cityName) async {
    isLoading.value = true;

    final NetworkResponse response =
    await WeatherRepository.fetchWeather(cityName);
    if (response.isSuccess) {
      final fetchedWeather = weatherModelFromJson(response.jsonResponse!);

      // Save to Hive for offline access
      await weatherBox.clear(); // Clear old data
      await weatherBox.add(fetchedWeather);  // Save the fetched weather

      // Update the observable
      weather.value = fetchedWeather;
    } else {
      Get.snackbar("Error", response.message ?? "Failed to fetch weather data");
    }
    isLoading.value = false;
  }
}
