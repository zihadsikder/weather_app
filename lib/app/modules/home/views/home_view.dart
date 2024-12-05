import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/core/confiq/app_colors.dart';
import 'package:weather_app/app/data/models/weather_model.dart';
import 'package:weather_app/app/modules/home/views/widgets/row_widgets.dart';

import '../../../core/constants/app_text_style.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF676BD0),
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.weather.value == null) {
          return const Center(child: Text("No weather data available"));
        }

        final weather = controller.weather.value!;
        final currentDateTime = DateTime.now();
        final sunriseTime =
        DateTime.fromMillisecondsSinceEpoch(weather.sunrise! * 1000);
        final sunsetTime =
        DateTime.fromMillisecondsSinceEpoch(weather.sunset! * 1000);

        return Center(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchWeather(weather.name ?? "Dhaka");
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildCityName(weather.name),
                  const SizedBox(height: 10),
                  buildDateTime(currentDateTime),
                  buildWeatherIcon(weather.icon),
                  const SizedBox(height: 10),
                  buildTemperature(weather.temp),
                  const SizedBox(height: 5),
                  buildDescription(weather.description),
                  const SizedBox(height: 24.0),
                  buildWeatherDetails(context, weather, sunriseTime, sunsetTime),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.fetchWeather("Dhaka");
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget buildCityName(String? cityName) {
    return Text(
      cityName ?? "Unknown City",
      style: AppTextStyle.headerTextStyle(fontSize: 36),
    );
  }

  Widget buildDateTime(DateTime currentDateTime) {
    return Column(
      children: [
        Text(
          DateFormat('hh:mm a').format(currentDateTime),
          style: AppTextStyle.normalTextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('EEEE, MMM d, yyyy').format(currentDateTime),
          style: AppTextStyle.normalTextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget buildWeatherIcon(String? iconCode) {
    return Image.network(
      "https://openweathermap.org/img/w/$iconCode.png",
      width: 100,
      height: 100,
    );
  }

  Widget buildTemperature(double? temp) {
    return Text(
      temp != null ? "${temp.toStringAsFixed(1)}°C" : "N/A",
      style: AppTextStyle.headerTextStyle(fontSize: 48),
    );
  }

  Widget buildDescription(String? description) {
    return Text(
      description?.capitalizeFirst ?? "No Description",
      style: AppTextStyle.normalTextStyle(fontSize: 18),
    );
  }

  Widget buildWeatherDetails(
      BuildContext context, WeatherModel weather, DateTime sunriseTime, DateTime sunsetTime) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RowWidgets(
            text1: "Max: ${weather.tempMax?.toStringAsFixed(1)}°C",
            text2: "Min: ${weather.tempMin?.toStringAsFixed(1)}°C",
          ),
          RowWidgets(
            text1: "Wind: ${weather.windSpeed?.toStringAsFixed(1)} m/s",
            text2: "Humidity: ${weather.humidity?.toString()}%",
          ),
          RowWidgets(
            text1: "Sunrise: ${DateFormat('hh:mm a').format(sunriseTime)}",
            text2: "Sunset: ${DateFormat('hh:mm a').format(sunsetTime)}",
          ),
        ],
      ),
    );
  }
}
