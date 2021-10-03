import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';

class WeatherAPI with ChangeNotifier {
  WeatherFactory wf = WeatherFactory("14f2548453598de9576fa192f1707fa1");
  double lat = 0;
  double long = 0;
  String city = "";

  void setCoord(List coords) {
    this.lat = coords.first;
    this.long = coords[1];
    notifyListeners();
  }

  void set setCity(String city) {
    this.city = city;
    notifyListeners();
  }

  Future<Weather?> get currentWeather async {
    try {
      return await wf.currentWeatherByLocation(this.lat, this.long);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Weather?> currentWeatherByCity(String city) async {
    try {
      return await wf.currentWeatherByCityName(city);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Weather>> weekForecast() async {
    return (await wf.fiveDayForecastByLocation(this.lat, this.long))
        .sublist(0, 5);
  }
}
