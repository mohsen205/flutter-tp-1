import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function fetchWeatherData;
  final String? cityName;
  final String? temperature;
  final String? weatherDescription;
  final String? humidity;

  MyDrawer({
    required this.textEditingController,
    required this.fetchWeatherData,
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Acceuil'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/');            },
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Météo'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/meteo');            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('gallerie'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/gallerie');            },
          ),
          ListTile(
            leading: Icon(Icons.public),
            title: Text('pays'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/pays');            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('contact'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/contact');            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('parametres'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/parametres');            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("connecte", false);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/authentification',
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
