import 'package:flutter/material.dart';
import 'package:oro_weather_app/pages/weatherPage.dart';
import 'package:oro_weather_app/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool isLight) {
    setState(() {
      _themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode, // Controls which theme is active
      home: WeatherPage(
        isLightMode: _themeMode == ThemeMode.light,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}
