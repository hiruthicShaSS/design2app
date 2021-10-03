import 'package:challenge4/service/weather.dart';
import 'package:challenge4/widgets/forecast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool todaySelected = true;

  bool tomorrowSelected = false;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  _getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);

    Provider.of<WeatherAPI>(context, listen: false)
        .setCoord([_locationData.latitude, _locationData.longitude]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: () {
                      setState(() {
                        tomorrowSelected = false;
                        todaySelected = true;
                      });
                    },
                    child: Text(
                      "Today",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: 12,
                  width: 12,
                  child: Visibility(
                    visible: todaySelected,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.3),
                            blurRadius: 35,
                            spreadRadius: 25,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent)),
                    onPressed: () {
                      setState(() {
                        tomorrowSelected = true;
                        todaySelected = false;
                      });
                    },
                    child: Text(
                      "Tomorrow",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    )),
                SizedBox(
                  height: 12,
                  width: 12,
                  child: Visibility(
                    visible: tomorrowSelected,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent.withOpacity(0.3),
                            blurRadius: 40,
                            spreadRadius: 15,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Consumer<WeatherAPI>(
          builder: (context, api, child) {
            return FutureBuilder(
              future: api.weekForecast(),
              builder: (context, AsyncSnapshot<List<Weather>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print(snapshot.data);
                  if (snapshot.data == null) return Text("No data");

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(snapshot.data!.length,
                          (index) => Forecast(weather: snapshot.data![index])),
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ],
    );
  }
}
