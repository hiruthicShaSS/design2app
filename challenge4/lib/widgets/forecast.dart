import 'package:challenge4/service/get_icon.dart';
import 'package:flutter/material.dart';
import 'package:challenge4/service/string_extension.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class Forecast extends StatelessWidget {
  const Forecast({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    String temperature = weather.temperature!.celsius!.toStringAsPrecision(2);
    String date = DateFormat("HH:MM").format(weather.date!).toString();

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.32,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.deepPurple.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(6, 6)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(fontSize: 18),
            ),
            getIcon(weather.weatherDescription!),
            Text(
              weather.weatherDescription!.capitalize(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("\u2103"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
