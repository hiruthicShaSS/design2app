import 'package:challenge4/service/weather.dart';
import 'package:challenge4/widgets/body.dart';
import 'package:challenge4/widgets/header.dart';
import 'package:flutter/material.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[800]!, Colors.deepPurple[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.8],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Header(),
              Body(),
            ],
          ),
        ),
      ),
    );
  }
}
