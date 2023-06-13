import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String cityName;

  MeteoDetailsPage({required this.cityName});

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  List<dynamic>? forecastData;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
    getMeteoForecast(widget.cityName);
  }

  Future<void> getMeteoForecast(String cityName) async {
    String countryName = 'Tunisia';
    String apiKey = '9c9b8c66694f9fe8d4da82c73a0d7cfb';

    String apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,$countryName&appid=$apiKey&units=metric&lang=fr';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          forecastData = data['list'];
        });
      } else {
        print('Failed to fetch forecast data: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch forecast data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo pour: ${widget.cityName}'),
      ),
      body: forecastData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: forecastData!.length,
              itemBuilder: (BuildContext context, int index) {
                var forecast = forecastData![index];
                var timestamp =
                    DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
                var dateFormat = DateFormat('EEEE, dd MMMM', 'fr_FR');
                var timeFormat = DateFormat('HH:mm');
                var date = dateFormat.format(timestamp);
                var time = timeFormat.format(timestamp);

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.lightBlue[100]!, Colors.lightBlue[300]!],
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            'https://openweathermap.org/img/wn/${forecast['weather'][0]['icon']}@2x.png',
                            width: 64,
                            height: 64,
                          ),
                          Text(
                            forecast['weather'][0]['description'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${forecast['main']['temp']}°C',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
