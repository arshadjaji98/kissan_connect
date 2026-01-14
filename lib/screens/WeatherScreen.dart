import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';
import 'dart:convert';
import 'Homescreen.dart';
import 'cropguide.dart';
import "MarketplaceScreen.dart";

class WeatherScreen extends StatefulWidget {
  final Map<String, dynamic>? weatherData;
  final String? cityName;

  const WeatherScreen({super.key, this.weatherData, this.cityName});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _forecastData;
  bool _isLoading = true;
  String _errorMessage = '';
  String _displayCity = '';
  String _userLocation = '';
  bool _usingFallbackWeather = false;
  int _bottomNavIndex = 1; // Weather tab selected

  @override
  void initState() {
    super.initState();

    // If cityName is provided from Marketplace, use it directly
    if (widget.cityName != null && widget.cityName!.isNotEmpty) {
      _displayCity = widget.cityName!;
      _fetchWeatherData(_displayCity);
    } else if (widget.weatherData != null && widget.weatherData!.isNotEmpty) {
      // Use passed weather data if available from HomeScreen
      _weatherData = widget.weatherData;
      _displayCity =
          widget.cityName ?? AppLocalizations.of(context)!.your_location;
      _extractForecastData(_weatherData!);
      setState(() {
        _isLoading = false;
      });
    } else {
      _fetchUserLocationAndWeather();
    }
  }

  Future<void> _fetchUserLocationAndWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // If we have a city name from widget, use it directly
      if (widget.cityName != null && widget.cityName!.isNotEmpty) {
        await _fetchWeatherData(widget.cityName!);
        return;
      }

      // Otherwise get from Firestore
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = AppLocalizations.of(context)!.user_not_logined_in;
          _isLoading = false;
        });
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final location =
            userData['location']?.toString().trim() ??
            userData['landArea']?.toString().trim() ??
            'Islamabad';
        _userLocation = location;
        await _fetchWeatherData(_userLocation);
      } else {
        await _fetchWeatherData('Islamabad');
      }
    } catch (e) {
      print(
        AppLocalizations.of(context)!.error_fetching_user_location +
            e.toString(),
      );
      await _fetchWeatherData('Islamabad');
    }
  }

  Future<void> _fetchWeatherData(String city) async {
    try {
      // First, get coordinates for the city using Open-Meteo geocoding
      final encodedCity = Uri.encodeComponent(city);
      final geocodeUri = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$encodedCity&count=1&language=en&format=json',
      );

      final geocodeResponse = await http.get(geocodeUri);

      if (geocodeResponse.statusCode == 200) {
        final geocodeData = json.decode(geocodeResponse.body);

        if (geocodeData['results'] != null &&
            geocodeData['results'].isNotEmpty) {
          final result = geocodeData['results'][0];
          final lat = result['latitude'];
          final lng = result['longitude'];
          final cityName = result['name'];

          // Then get comprehensive weather data from Open-Meteo
          final weatherUri = Uri.parse(
            'https://api.open-meteo.com/v1/forecast?'
            'latitude=$lat&'
            'longitude=$lng&'
            'current_weather=true&'
            'hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&'
            'daily=temperature_2m_max,temperature_2m_min,weathercode,precipitation_sum,precipitation_hours,windspeed_10m_max&'
            'timezone=auto&forecast_days=7',
          );

          final weatherResponse = await http.get(weatherUri);

          if (weatherResponse.statusCode == 200) {
            final weatherApiData = json.decode(weatherResponse.body);
            setState(() {
              _weatherData = weatherApiData;
              _weatherData!['location_name'] = cityName;
              _displayCity = cityName;
            });

            // Extract forecast data
            _extractForecastData(weatherApiData);
            setState(() {
              _isLoading = false;
            });
          } else {
            await _fetchWeatherWithFallback();
          }
        } else {
          await _fetchWeatherWithFallback();
        }
      } else {
        await _fetchWeatherWithFallback();
      }
    } catch (e) {
      print(
        AppLocalizations.of(context)!.error_fetching_weather + e.toString(),
      );
      await _fetchWeatherWithFallback();
    }
  }

  Future<void> _fetchWeatherWithFallback() async {
    try {
      setState(() {
        _usingFallbackWeather = true;
      });

      // Fallback to Islamabad coordinates
      final fallbackUri = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?'
        'latitude=33.6844&'
        'longitude=73.0479&'
        'current_weather=true&'
        'hourly=temperature_2m,relativehumidity_2m,precipitation,weathercode,windspeed_10m&'
        'daily=temperature_2m_max,temperature_2m_min,weathercode,precipitation_sum,precipitation_hours,windspeed_10m_max&'
        'timezone=auto&forecast_days=7',
      );

      final response = await http.get(fallbackUri);
      if (response.statusCode == 200) {
        final weatherApiData = json.decode(response.body);
        setState(() {
          _weatherData = weatherApiData;
          _weatherData!['location_name'] = 'Islamabad';
          _displayCity = 'Islamabad';
        });

        // Extract forecast data
        _extractForecastData(weatherApiData);
        setState(() {
          _isLoading = false;
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage = AppLocalizations.of(
            context,
          )!.unable_to_fetch_weather_data_please_check_internet;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load weather data: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _extractForecastData(Map<String, dynamic> weatherData) {
    if (weatherData['daily'] == null) return;

    final daily = weatherData['daily'];
    final List<dynamic> timeList = daily['time'] ?? [];
    final List<dynamic> tempMaxList = daily['temperature_2m_max'] ?? [];
    final List<dynamic> tempMinList = daily['temperature_2m_min'] ?? [];
    final List<dynamic> weatherCodeList = daily['weathercode'] ?? [];
    final List<dynamic> precipitationList = daily['precipitation_sum'] ?? [];
    final List<dynamic> windSpeedList = daily['windspeed_10m_max'] ?? [];

    List<Map<String, dynamic>> forecastList = [];

    for (int i = 0; i < timeList.length; i++) {
      if (i > 0) {
        // Skip today (index 0) as we show it separately
        forecastList.add({
          'date': timeList[i],
          'day': _getDayOfWeek(DateTime.parse(timeList[i])),
          'temp_max': tempMaxList.isNotEmpty && i < tempMaxList.length
              ? tempMaxList[i]?.toDouble() ?? 0.0
              : 0.0,
          'temp_min': tempMinList.isNotEmpty && i < tempMinList.length
              ? tempMinList[i]?.toDouble() ?? 0.0
              : 0.0,
          'weather_code':
              weatherCodeList.isNotEmpty && i < weatherCodeList.length
              ? weatherCodeList[i] ?? 0
              : 0,
          'precipitation':
              precipitationList.isNotEmpty && i < precipitationList.length
              ? precipitationList[i]?.toDouble() ?? 0.0
              : 0.0,
          'wind_speed': windSpeedList.isNotEmpty && i < windSpeedList.length
              ? windSpeedList[i]?.toDouble() ?? 0.0
              : 0.0,
        });
      }
    }

    setState(() {
      _forecastData = {
        'forecast': forecastList,
        'today': {
          'temp_max': tempMaxList.isNotEmpty
              ? tempMaxList[0]?.toDouble() ?? 0.0
              : 0.0,
          'temp_min': tempMinList.isNotEmpty
              ? tempMinList[0]?.toDouble() ?? 0.0
              : 0.0,
          'weather_code': weatherCodeList.isNotEmpty
              ? weatherCodeList[0] ?? 0
              : 0,
        },
      };
    });
  }

  String _getDayOfWeek(DateTime date) {
    final days = [
      AppLocalizations.of(context)!.sun,
      AppLocalizations.of(context)!.mon,
      AppLocalizations.of(context)!.tue,
      AppLocalizations.of(context)!.wed,
      AppLocalizations.of(context)!.thu,
      AppLocalizations.of(context)!.fri,
      AppLocalizations.of(context)!.sat,
    ];
    return days[date.weekday % 7];
  }

  String _getWeatherConditionFromCode(int weatherCode) {
    // Clear
    if (weatherCode == 0) return AppLocalizations.of(context)!.clear;
    if (weatherCode == 1) return AppLocalizations.of(context)!.clearSky;
    if (weatherCode == 2) return AppLocalizations.of(context)!.partlyCloudy;

    // Clouds
    if (weatherCode == 3) return AppLocalizations.of(context)!.cloudy;

    // Fog
    if (weatherCode == 45 || weatherCode == 48)
      return AppLocalizations.of(context)!.fog;

    // Drizzle
    if (weatherCode >= 51 && weatherCode <= 57)
      return AppLocalizations.of(context)!.drizzle;

    // Rain
    if (weatherCode >= 61 && weatherCode <= 67)
      return AppLocalizations.of(context)!.rain;
    if (weatherCode >= 80 && weatherCode <= 86)
      return AppLocalizations.of(context)!.rain;
    // Snow
    if (weatherCode >= 71 && weatherCode <= 77)
      return AppLocalizations.of(context)!.snow;

    // Thunderstorm
    if (weatherCode >= 95 && weatherCode <= 99)
      return AppLocalizations.of(context)!.thunderstorm;

    return AppLocalizations.of(context)!.clear;
  }

  String _getWeatherDescriptionFromCode(int weatherCode) {
    // Clear
    if (weatherCode == 0) return AppLocalizations.of(context)!.clearSky;
    if (weatherCode == 1) return AppLocalizations.of(context)!.mainlyClear;
    if (weatherCode == 2) return AppLocalizations.of(context)!.partlyCloudy;

    // Clouds
    if (weatherCode == 3) return AppLocalizations.of(context)!.overcast;

    // Fog
    if (weatherCode == 45) return AppLocalizations.of(context)!.fog;
    if (weatherCode == 48)
      return AppLocalizations.of(context)!.depositingRimeFog;
    // Drizzle
    if (weatherCode == 51) return AppLocalizations.of(context)!.lightDrizzle;
    if (weatherCode == 53) return AppLocalizations.of(context)!.moderateDrizzle;
    if (weatherCode == 55) return AppLocalizations.of(context)!.denseDrizzle;
    // Rain
    if (weatherCode == 61) return AppLocalizations.of(context)!.slightRain;
    if (weatherCode == 63) return AppLocalizations.of(context)!.moderateRain;
    if (weatherCode == 65) return AppLocalizations.of(context)!.heavyRain;
    // Snow
    if (weatherCode == 71) return AppLocalizations.of(context)!.slightSnow;
    if (weatherCode == 73) return AppLocalizations.of(context)!.moderateSnow;
    if (weatherCode == 75) return AppLocalizations.of(context)!.heavySnow;
    // Thunderstorm
    if (weatherCode == 95) return AppLocalizations.of(context)!.thunderstorm;
    if (weatherCode == 96)
      return AppLocalizations.of(context)!.thunderstormWithHail;

    return AppLocalizations.of(context)!.clearSky;
  }

  IconData _getWeatherIcon(int weatherCode) {
    final condition = _getWeatherConditionFromCode(weatherCode).toLowerCase();
    if (condition.contains('clear')) {
      return Icons.wb_sunny;
    } else if (condition.contains('cloud')) {
      return Icons.cloud;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return Icons.beach_access;
    } else if (condition.contains('snow')) {
      return Icons.ac_unit;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return Icons.flash_on;
    } else if (condition.contains('fog') ||
        condition.contains('mist') ||
        condition.contains('haze')) {
      return Icons.blur_on;
    }
    return Icons.wb_sunny;
  }

  Color _getWeatherIconColor(int weatherCode) {
    final condition = _getWeatherConditionFromCode(weatherCode).toLowerCase();
    if (condition.contains('clear')) {
      return Colors.amber;
    } else if (condition.contains('cloud')) {
      return Colors.grey;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return Colors.blue;
    } else if (condition.contains('snow')) {
      return Colors.lightBlue;
    } else if (condition.contains('thunder') || condition.contains('storm')) {
      return Colors.deepPurple;
    } else if (condition.contains('fog') ||
        condition.contains('mist') ||
        condition.contains('haze')) {
      return Colors.grey[400]!;
    }
    return Colors.amber;
  }

  Map<String, dynamic>? getCurrentWeather() {
    if (_weatherData == null || _weatherData!['current_weather'] == null) {
      return null;
    }

    final current = _weatherData!['current_weather'];
    final weatherCode = current['weathercode'] ?? 0;

    // Get humidity from hourly data if available
    double humidity = 50.0;
    if (_weatherData!['hourly'] != null &&
        _weatherData!['hourly']['relativehumidity_2m'] != null &&
        _weatherData!['hourly']['relativehumidity_2m'].isNotEmpty) {
      humidity =
          _weatherData!['hourly']['relativehumidity_2m'][0]?.toDouble() ?? 50.0;
    }

    return {
      'main': {
        'temp': current['temperature']?.toDouble() ?? 0.0,
        'humidity': humidity,
        'feels_like': current['temperature']?.toDouble() ?? 0.0,
      },
      'weather': [
        {
          'main': _getWeatherConditionFromCode(weatherCode),
          'description': _getWeatherDescriptionFromCode(weatherCode),
        },
      ],
      'wind': {'speed': current['windspeed']?.toDouble() ?? 0.0},
    };
  }

  Widget _buildMainWeatherCard() {
    final localization = AppLocalizations.of(context)!;
    final currentWeather = getCurrentWeather();
    final todayForecast = _forecastData?['today'];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.grey),
              const SizedBox(width: 5),
              Text(
                _displayCity,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (_usingFallbackWeather)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    localization.approximate,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.orange[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Weather icon moved to left, temperature centered
          Row(
            children: [
              // Weather icon on left
              if (currentWeather != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Icon(
                    _getWeatherIcon(
                      currentWeather['weather'][0]['main'] == 'Clear' ? 0 : 1,
                    ),
                    size: 70,
                    color: _getWeatherIconColor(
                      currentWeather['weather'][0]['main'] == 'Clear' ? 0 : 1,
                    ),
                  ),
                ),

              // Temperature and condition centered
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentWeather != null)
                      Text(
                        '${currentWeather['main']['temp']?.round() ?? 0}°C',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 8),
                    if (currentWeather != null)
                      Text(
                        currentWeather['weather'][0]['main'] ??
                            localization.clear,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),

              // Empty space for balance
              const SizedBox(width: 70),
            ],
          ),

          const SizedBox(height: 10),
          if (currentWeather != null)
            Text(
              '${AppLocalizations.of(context)!.feels_like} '
              '${currentWeather['main']['feels_like']?.round() ?? 0}°C',
            ),
          if (todayForecast != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'High: ${todayForecast['temp_max']?.round() ?? 0}°C • Low: ${todayForecast['temp_min']?.round() ?? 0}°C',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 20),
          if (currentWeather != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherDetail(
                  Icons.water_drop,
                  '${currentWeather['main']['humidity']?.round() ?? 0}%',
                  localization.humidity,
                  Colors.blue,
                ),
                _buildWeatherDetail(
                  Icons.air,
                  '${currentWeather['wind']['speed']?.toStringAsFixed(1) ?? '0.0'} km/h',
                  localization.wind,
                  Colors.green,
                ),
                _buildWeatherDetail(
                  Icons.water,
                  '10%',
                  localization.rain,
                  Colors.blue,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildHeatWarningCard() {
    final localization = AppLocalizations.of(context)!;
    final currentWeather = getCurrentWeather();
    final temp = currentWeather?['main']['temp'] ?? 0.0;

    if (temp < 35)
      return const SizedBox.shrink(); // Only show warning for high temps

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.red, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.high_temperature_alert,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Temperature is ${temp.round()}°C. Ensure crops are well-irrigated and monitor for heat stress.',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecastRow() {
    final localization = AppLocalizations.of(context)!;
    if (_weatherData == null || _weatherData!['hourly'] == null) {
      return SizedBox(
        height: 130, // Increased height to prevent overflow
        child: Center(child: Text('Hourly forecast not available')),
      );
    }

    final hourly = _weatherData!['hourly'];
    final timeList = hourly['time'] as List<dynamic>? ?? [];
    final tempList = hourly['temperature_2m'] as List<dynamic>? ?? [];
    final weatherCodeList = hourly['weathercode'] as List<dynamic>? ?? [];

    final now = DateTime.now();
    int currentIndex = 0;

    // Find current time index
    for (int i = 0; i < timeList.length; i++) {
      final forecastTime = DateTime.parse(timeList[i]);
      if (forecastTime.isAfter(now)) {
        currentIndex = i;
        break;
      }
    }

    return SizedBox(
      height: 130, // Increased height to prevent overflow
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8, // Next 8 hours
        itemBuilder: (context, index) {
          final hourIndex = currentIndex + index;
          if (hourIndex >= timeList.length) return Container();
          final l10n = AppLocalizations.of(context)!;

          final time = DateTime.parse(timeList[hourIndex]);
          final hour = time.hour;
          final displayTime = hour == 12
              ? '12 ${l10n.pm}'
              : hour > 12
              ? '${hour - 12} ${l10n.pm}'
              : hour == 0
              ? '12 ${l10n.am}'
              : '$hour ${l10n.am}';
          final temp = tempList[hourIndex]?.toDouble() ?? 0.0;
          final weatherCode = weatherCodeList[hourIndex] ?? 0;

          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 16,
            ), // Reduced horizontal padding
            decoration: BoxDecoration(
              color: index == 0 ? Colors.white : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(15),
              border: index == 0
                  ? Border.all(color: Colors.grey.shade300)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  index == 0 ? localization.now : displayTime,
                  style: TextStyle(
                    fontSize: 14, // Slightly smaller font
                    color: index == 0 ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Icon(
                  _getWeatherIcon(weatherCode),
                  color: index == 0
                      ? _getWeatherIconColor(weatherCode)
                      : Colors.grey,
                  size: 28, // Slightly smaller icon
                ),
                const SizedBox(height: 8),
                Text(
                  '${temp.round()}°',
                  style: const TextStyle(
                    fontSize: 16, // Slightly smaller font
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyForecastColumn() {
    if (_forecastData == null || _forecastData!['forecast'] == null) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('7-day forecast not available')),
      );
    }

    final forecastList = _forecastData!['forecast'] as List<dynamic>;

    return Column(
      children: forecastList.map<Widget>((dayData) {
        return _buildDailyItem(
          dayData['day'],
          _getWeatherIcon(dayData['weather_code']),
          _getWeatherConditionFromCode(dayData['weather_code']),
          '${dayData['temp_max']?.round() ?? 0}° / ${dayData['temp_min']?.round() ?? 0}°',
          dayData['precipitation'] > 0
              ? '${dayData['precipitation']} mm'
              : null,
        );
      }).toList(),
    );
  }

  Widget _buildDailyItem(
    String day,
    IconData icon,
    String condition,
    String temp,
    String? precipitation,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 10),
              Text(condition),
              if (precipitation != null) ...[
                const SizedBox(width: 10),
                Icon(Icons.water_drop, color: Colors.blue, size: 16),
                const SizedBox(width: 4),
                Text(
                  precipitation,
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ],
            ],
          ),
          Text(temp, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((
        doc,
      ) {
        if (doc.exists) {
          final userData = doc.data() as Map<String, dynamic>;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                userLocation:
                    userData['location'] ??
                    widget.cityName ??
                    AppLocalizations.of(context)!.your_location,
                userName:
                    userData['name'] ?? AppLocalizations.of(context)!.farmer,
                selectedCrops: List<String>.from(
                  userData['selectedCrops'] ?? ['Wheat'],
                ),
                primaryCrop:
                    userData['primaryCrop'] ??
                    AppLocalizations.of(context)!.wheat,
              ),
            ),
            (route) => false,
          );
        }
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userLocation:
                widget.cityName ?? AppLocalizations.of(context)!.your_location,
            userName: AppLocalizations.of(context)!.farmer,
            selectedCrops: ['Wheat'],
            primaryCrop: AppLocalizations.of(context)!.wheat,
          ),
        ),
        (route) => false,
      );
    }
  }

  void _navigateToCropGuide(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CropGuideScreen()),
    );
  }

  void _navigateToMarketplace(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((
        doc,
      ) {
        if (doc.exists) {
          final userData = doc.data() as Map<String, dynamic>;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MarketplaceScreen(
                userLocation:
                    userData['location'] ??
                    widget.cityName ??
                    AppLocalizations.of(context)!.your_location,
                userName:
                    userData['name'] ?? AppLocalizations.of(context)!.farmer,
              ),
            ),
            (route) => false,
          );
        }
      });
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MarketplaceScreen(
            userLocation:
                widget.cityName ?? AppLocalizations.of(context)!.your_location,
            userName: 'Farmer',
          ),
        ),
        (route) => false,
      );
    }
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0: // Home
        _navigateToHome(context);
        break;
      case 1: // Weather - Already here
        break;
      case 2: // Crop Guide
        _navigateToCropGuide(context);
        break;
      case 3: // Marketplace
        _navigateToMarketplace(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: Container(), // Remove back button
        title: Text(
          localization.weather_forecast,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: const [], // Remove refresh button
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 20),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchUserLocationAndWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                    ),
                    child: Text(localization.retry),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Weather Card
                    _buildMainWeatherCard(),
                    const SizedBox(height: 20),

                    // Heat Warning (if applicable)
                    _buildHeatWarningCard(),
                    const SizedBox(height: 20),

                    // Today's Forecast Section
                    Text(
                      localization.todays_forecast,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildHourlyForecastRow(),
                    const SizedBox(height: 20),

                    // 7-Day Forecast Section
                    Text(
                      localization.seven_days_forecast,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildDailyForecastColumn(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: localization.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: localization.weather,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: localization.crop_guide,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: localization.marketplace,
          ),
        ],
      ),
    );
  }
}
