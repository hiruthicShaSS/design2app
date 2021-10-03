import 'package:challenge4/service/weather.dart';
import 'package:challenge4/views/manage_city.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<WeatherAPI>(
                builder: (context, api, child) {
                  print(api.city);

                  return Text(
                    api.city,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ManageCity()));
                  },
                  icon: Icon(Icons.more_vert, color: Colors.white)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Consumer<WeatherAPI>(builder: (context, api, child) {
            return FutureBuilder(
                future: api.currentWeather,
                builder: (context, AsyncSnapshot<Weather?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) return Text("No data!");

                    api.city = snapshot.data!.areaName!;

                    String temperature = snapshot.data!.temperature!.celsius!
                        .toStringAsPrecision(2);
                    String date = DateFormat("EEEE, MMMM d")
                        .format(snapshot.data!.date!)
                        .toString();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.weatherMain!,
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(date,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 17)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              temperature,
                              style: GoogleFonts.openSans(
                                fontSize: 80,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text("\u2103"),
                          ],
                        )
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                });
          }),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        ],
      ),
    );
  }
}
