import 'package:challenge4/service/weather.dart';
import 'package:challenge4/weatherapp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: GoogleFonts.roboto(color: Colors.white),
          bodyText2: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      home: ChangeNotifierProvider(
          create: (_) => WeatherAPI(), child: WeatherApp()),
    ),
  );
}
