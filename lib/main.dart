import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/core/constants/theme_data.dart';

import 'app/data/models/weather_model.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherModelAdapter());
  await Hive.openBox<WeatherModel>('weather');  // Ensure it's opened
  runApp(
    GetMaterialApp(
      title: "Assignment Two",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      theme: AppThemeData.lightThemeData,
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
    ),
  );
}
