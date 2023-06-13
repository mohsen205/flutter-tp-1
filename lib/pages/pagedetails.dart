import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaysDetailsPage extends StatelessWidget {
  final Map<String, dynamic> countryData;

  const PaysDetailsPage({required this.countryData});

  @override
  Widget build(BuildContext context) {
    final String countryName = countryData['name']['common'] ?? '';
    final String countryCapital = countryData['capital'][0] ?? '';
    final String flagUrl = countryData['flags']['png'] ?? '';
    final String language = countryData['languages']['ara'] ?? '';
    final String region = countryData['region'] ?? '';
    final double area = countryData['area'] ?? 0;
    final String timezone = countryData['timezones'][0] ?? '';
    final int population = countryData['population'] ?? 0;

    final String arabicCountryName =
    utf8.decode(countryData['name']['nativeName']['ara']['official'].toString().codeUnits);

    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(
        title: Text(countryName),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Center(
                child: Image.network(
                  flagUrl,
                  height: 100,
                  width: 150,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Country Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(countryName),
              SizedBox(height: 8),

              Text(arabicCountryName),
              SizedBox(height: 16),
              Text(
                'Administration:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Country Capital: $countryCapital',

              ),
              Text(
                'Language: $language',
              ),
              SizedBox(height: 16),
              Text(
                'Géographie:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Region: $region',
              ),
              Text(
                'Area: ${formatter.format(area)} sq km',
              ),
              Text(
                'Timezone: $timezone',
              ),
              SizedBox(height: 16),
              Text(
                'Démographie:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Population: ${formatter.format(population)}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
