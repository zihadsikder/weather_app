import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'app/core/constants/theme_data.dart';

import 'app/routes/app_pages.dart';


void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(WeatherModelAdapter());
  // await Hive.openBox<WeatherModel>('weather');
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
