import 'package:challenge4/service/get_icon.dart';
import 'package:challenge4/service/weather.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:challenge4/service/string_extension.dart';

class ManageCity extends StatefulWidget {
  const ManageCity({Key? key}) : super(key: key);

  @override
  _ManageCityState createState() => _ManageCityState();
}

class _ManageCityState extends State<ManageCity> {
  List<String> cities = ["lagos", "lisbon", "london"];
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[800]!, Colors.deepPurple[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(),
              SavedCities(cities: cities),
              Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  child: ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(25),
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Center(
                          child: Text(
                        "ADD CITY",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  onTap: () => onCityAdd(cityController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCityAdd(TextEditingController controller) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.8),
              title: Text("Add City"),
              content: TextField(
                controller: controller,
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      WeatherAPI()
                          .currentWeatherByCity(controller.text)
                          .then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("City not available!")));
                        } else {
                          setState(() {
                            cities.add(controller.text);
                          });
                        }
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text("Add")),
              ],
            ));
  }
}

class SavedCities extends StatelessWidget {
  const SavedCities({Key? key, this.cities: const []}) : super(key: key);
  final List<String> cities;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.5, color: Colors.white.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    cities[index].capitalize(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FutureBuilder(
                  future: WeatherAPI().currentWeatherByCity(cities[index]),
                  builder: (context, AsyncSnapshot<Weather?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) return Text("No data");

                      String temperature = snapshot.data!.temperature!.celsius!
                          .toStringAsPrecision(2);

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                getIcon(snapshot.data!.weatherDescription!),
                                SizedBox(width: 20),
                                Text(
                                  temperature,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              snapshot.data!.weatherDescription!.capitalize(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          Text(
            "Manage City",
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
