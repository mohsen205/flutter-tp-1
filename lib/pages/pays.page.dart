import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pagedetails.dart';

class PaysPage extends StatefulWidget {
  @override
  _PaysPageState createState() => _PaysPageState();
}

class _PaysPageState extends State<PaysPage> {
  List<dynamic> countries = [];
  List<dynamic> filteredCountries = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(Uri.https('restcountries.com', '/v3.1/all'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          setState(() {
            countries = data;
            filteredCountries = data;

          });
        } else {
          print('Invalid data format: $data');
        }
      } else {
        print('Failed to fetch countries: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching countries: $error');
    }
  }
  void filterCountries(String query) {
    if (query.isNotEmpty) {
      setState(() {
        filteredCountries = countries.where((country) {
          final name = country['name'];
          return name != null && name['common'].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    } else {
      setState(() {
        filteredCountries = countries;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pays'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterCountries,
              decoration: InputDecoration(
                labelText: 'Rechercher un pays',
              ),
            ),
          ),
          Expanded(
            child: filteredCountries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                if (country != null && country is Map) {
                  final name = country['name'];
                  final capital = country['capital'];
                  if (name != null && capital != null) {
                    return ListTile(
                      title: Text(name['common'] ?? ''),
                      subtitle: Text('Capital: ${capital[0] ?? ''}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaysDetailsPage(countryData: filteredCountries[index]),
                          ),
                        );
                      },



                    );
                  } else {
                    print('Invalid country data: $country');
                  }
                } else {
                  print('Invalid country format: $country');
                }
                return SizedBox(); // Placeholder widget when data is invalid
              },
            ),
          ),
        ],
      ),
    );
  }
}
