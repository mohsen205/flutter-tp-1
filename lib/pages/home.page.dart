import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../menu/drawer.widget.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> allPrefs;

  HomePage({required this.allPrefs});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? temperature;
  String? weatherDescription;
  String? humidity;
  String? cityName;
  String? iconUrl;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    String cityName = _textEditingController.text;
    String countryName = 'Tunisia';
    String apiKey = '9c9b8c66694f9fe8d4da82c73a0d7cfb';

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName,$countryName&appid=$apiKey&units=metric';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        double temp = data['main']['temp'];
        String description = data['weather'][0]['description'];
        int humid = data['main']['humidity'];
        String icon = data['weather'][0]['icon'];
        print("the icon is "+icon);

        setState(() {
          temperature = temp.toStringAsFixed(1);
          weatherDescription = description;
          humidity = humid.toStringAsFixed(1);
          cityName = data['name'];
          iconUrl = 'https://openweathermap.org/img/wn/$icon.png';
        });
      } else {
        print('Failed to fetch weather data: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch weather data: $error');
    }
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/inscription');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: MyDrawer(
        textEditingController: _textEditingController,
        fetchWeatherData: fetchWeatherData,
        cityName: cityName,
        temperature: temperature,
        weatherDescription: weatherDescription,
        humidity: humidity,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/meteo');
            },
            child: Image.asset('assets/images/icons8-partly-cloudy-day-96.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/gallerie');
            },
            child: Image.asset('assets/images/icons8-image-96.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/pays');
            },
            child: Image.asset('assets/images/icons8-earth-96.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
            child: Image.asset('assets/images/icons8-male-user-96.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/parametres');
            },
            child: Image.asset('assets/images/icons8-gear-96.png'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/authentification');
            },
            child: Image.asset('assets/images/icons8-exit-96.png'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logout(context),
        child: Icon(Icons.logout),
      ),
    );
  }

}
