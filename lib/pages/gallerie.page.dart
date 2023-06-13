import 'package:flutter/material.dart';

class GalleriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallerie'),
      ),
      body: Center(
        child: Text(
          'Gallerie',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
