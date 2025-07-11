import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oro_weather_app/service/weathterService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherPage extends StatefulWidget {
  final bool isLightMode;
  final ValueChanged<bool>? onThemeChanged;

  const WeatherPage({
    super.key,
    this.isLightMode = true,
    this.onThemeChanged,
  });

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController cityController = TextEditingController();
  final weathterService = WeathterService();

  Map<String, dynamic>? weatherData;
  List<String> recentSearchedCities = [];

  Future<void> fetchWeather() async {
    final data = await weathterService.fetchWeather(cityController.text.trim());
    if (data != null) {
      setState(() {
        weatherData = data;
      });
      await saveSearchedCities(cityController.text.trim());
    }
  }

  Future<void> loadRecentSearchedCites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearchedCities = prefs.getStringList('recentSearchedCities') ?? [];
    });
  }

  Future<void> saveSearchedCities(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (cityName.isEmpty) return;

    recentSearchedCities.remove(cityName);
    recentSearchedCities.insert(0, cityName);
    if (recentSearchedCities.length > 5) {
      recentSearchedCities = recentSearchedCities.sublist(0, 5);
    }

    await prefs.setStringList('recentSearchedCities', recentSearchedCities);
    setState(() {});
  }

  String getLottieAsset(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/sun.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      default:
        return 'assets/cloud.json';
    }
  }

  Color getBackgroundColor(String condition, BuildContext context) {
    // Use theme color as default
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.orange.shade100;
      case 'clouds':
        return Colors.blueGrey.shade100;
      case 'rain':
        return Colors.blue.shade200;
      case 'thunderstorm':
        return Colors.deepPurple.shade200;
      case 'snow':
        return Colors.cyan.shade100;
      default:
        return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  @override
  void initState() {
    loadRecentSearchedCites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = widget.isLightMode;
    final weatherMain = weatherData?['weather'][0]['main'];
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            isLightMode ? "Light Theme" : "Dark Theme",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.appBarTheme.foregroundColor ?? theme.primaryColor,
            ),
          ),
          Switch(
            value: isLightMode,
            onChanged: widget.onThemeChanged,
            activeColor: theme.colorScheme.secondary,
          ),
        ],
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        title: Text(
          "☁️ Weather App",
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.appBarTheme.foregroundColor ?? theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchWeather,
        child: Container(
          decoration: BoxDecoration(
            color: weatherMain != null
                ? getBackgroundColor(weatherMain, context)
                : theme.scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: cityController,
                        decoration: InputDecoration(
                          labelText: 'Enter City Name',
                          hintText: 'e.g., Lucknow',
                          filled: true,
                          fillColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: Icon(Icons.pin_drop_outlined, color: theme.iconTheme.color),
                        ),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: fetchWeather,
                      icon: const Icon(Icons.search),
                      color: theme.iconTheme.color,
                      style: IconButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                if (recentSearchedCities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recent Searches",
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: recentSearchedCities.map((city) {
                            return ActionChip(
                              label: Text(city, style: theme.textTheme.bodyMedium),
                              onPressed: () {
                                cityController.text = city;
                                fetchWeather();
                              },
                              backgroundColor: theme.chipTheme.backgroundColor,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                weatherData != null
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Lottie.asset(
                                getLottieAsset(weatherMain),
                                height: 180,
                              ),
                              const SizedBox(height: 10),
                              Card(
                                color: theme.cardColor,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${weatherData!['main']['temp']} °C",
                                        style: theme.textTheme.displaySmall?.copyWith(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.pin_drop_outlined,
                                            color: theme.iconTheme.color,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${weatherData!['name']}, ${weatherData!['sys']['country']}",
                                            style: theme.textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 3 / 2,
                                children: [
                                  WeatherCard(
                                    icon: Icons.device_thermostat,
                                    title: "Feels Like",
                                    value: "${weatherData!['main']['feels_like']} °C",
                                    color: Colors.redAccent,
                                  ),
                                  WeatherCard(
                                    icon: Icons.cloud,
                                    title: "Condition",
                                    value: "${weatherData!['weather'][0]['description']}",
                                    color: Colors.grey,
                                  ),
                                  WeatherCard(
                                    icon: Icons.water_drop,
                                    title: "Humidity",
                                    value: "${weatherData!['main']['humidity']}%",
                                    color: Colors.blue,
                                  ),
                                  WeatherCard(
                                    icon: Icons.air,
                                    title: "Wind Speed",
                                    value: "${weatherData!['wind']['speed']} m/s",
                                    color: Colors.green,
                                  ),
                                  WeatherCard(
                                    icon: Icons.cloud_queue,
                                    title: "Cloudiness",
                                    value: "${weatherData!['clouds']['all']}%",
                                    color: Colors.indigo,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "⛅ Search a city to see the weather",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const WeatherCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 5),
            Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
