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
        backgroundColor: Color(0xFF676BD0),
        title: Text(
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
        final DateTime currentDateTime = DateTime.now();
        final DateTime sunriseTime =
            DateTime.fromMillisecondsSinceEpoch(weather.sys!.sunrise! * 1000);
        final DateTime sunsetTime =
            DateTime.fromMillisecondsSinceEpoch(weather.sys!.sunset! * 1000);

        return Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  weather.name ?? "Unknown City",
                  style: AppTextStyle.headerTextStyle(fontSize: 36),
                ),
                const SizedBox(height: 10),
                buildDateTime(currentDateTime),
                Image.network(
                  "https://openweathermap.org/img/w/${weather.weather?[0].icon}.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10),
                Text(
                  "${weather.main?.temp?.toStringAsFixed(1)}°C",
                  style: AppTextStyle.headerTextStyle(fontSize: 48),
                ),
                const SizedBox(height: 5),
                Text(
                  weather.weather?[0].description?.capitalizeFirst ??
                      "No Description",
                  style: AppTextStyle.normalTextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24.0),
                buildContainer(context, weather, sunriseTime, sunsetTime)
              ],
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

  Column buildDateTime(DateTime currentDateTime) {
    return Column(
      children: [
        Text(
          DateFormat('hh:mm a').format(currentDateTime),
          style: AppTextStyle.normalTextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('EEEE, MMM d, yyyy').format(currentDateTime),
          style: AppTextStyle.normalTextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Container buildContainer(BuildContext context, WeatherModel weather,
      DateTime sunriseTime, DateTime sunsetTime) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).height * 0.38,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RowWidgets(
            text1: "Max: ${weather.main?.tempMax?.toStringAsFixed(1)}°C",
            text2: "Min: ${weather.main?.tempMin?.toStringAsFixed(1)}°C",
          ),
          RowWidgets(
            text1: "Wind: ${weather.wind?.speed?.toStringAsFixed(1)} m/s",
            text2: "Humidity: ${weather.main?.humidity?.toString()}%",
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
