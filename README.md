Objective:
Real-time weather data by city name
Weather condition–based Lottie animations
Clean, responsive Flutter UI
Easy integration with OpenWeatherMap API


Prerequisites:
1. install Flutter SDK (stable version) from browser 

2. Android Studio / VSCode
3. A valid OpenWeatherMap API Key


Setup Instructions:
1. Clone the repository
In vs code write on terminal (bash)
git clone https://github.com/your-username/oro-weather-app.git
cd oro-weather-app

2. Install dependencies
bash
flutter pub get
The app uses the following packages:
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
  lottie: ^3.1.0
Make sure these are present in your pubspec.yaml. Then run:
flutter pub get
Using LottieFiles
Download weather animations from https://lottiefiles.com

Place them in:
assets/animations/

3. Add your API key
Open the file:
bash
lib/services/weather_service.dart
Replace:
dart
const String apiKey = 'YOUR_API_KEY';
with your actual OpenWeatherMap API key.
You can get a free API key at: https://openweathermap.org/api


4. Run the app
bash
flutter run

FOLDER STRUCTURE:
oro-weather-app/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── services/
│   ├── screens/
│   └── widgets/
├── assets/
│   └── animations/
├── pubspec.yaml
└── README.md


Author
Abhinav Singh
📧 abhinavsinghh2019@gmail.com
🌐 https://github.com/abhinavv22
