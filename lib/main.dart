import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/inscription.page.dart';
import './pages/authentification.page.dart';
import './pages/home.page.dart';
import './pages/meteo.page.dart';
import './pages/gallerie.page.dart';
import './pages/parametres.page.dart';
import './pages/pays.page.dart';
import './pages/contact.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? connecte;
  Map<String, dynamic> allPrefs = {};

  @override
  void initState() {
    super.initState();
    logSharedPreferences();
    checkConnecteStatus();
  }

  void logSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      allPrefs = prefs.getKeys().fold({}, (prev, key) {
        prev[key] = prefs.get(key);
        return prev;
      });
    });
    print('Shared Preferences:');
    print(allPrefs);
  }

  void checkConnecteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      connecte = prefs.getBool('connecte');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connexion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: connecte == true ? '/' : '/inscription',
      routes: {
        '/': (context) => HomePage(allPrefs: allPrefs),
        '/inscription': (context) => InscriptionPage(),
        '/authentification': (context) => AuthentificationPage(),
        '/meteo': (context) => MeteoPage(),
        '/gallerie': (context) => GalleriePage(),
        '/parametres': (context) => ParametresPage(),
        '/pays': (context) => PaysPage(),
        '/contact': (context) => ContactPage(),
      },
    );
  }
}
