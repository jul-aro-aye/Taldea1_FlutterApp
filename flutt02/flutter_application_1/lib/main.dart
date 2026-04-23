import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taldea1 Flutter App',
      home: Scaffold(
        body: Center(
          child: Text('Kaixo mundua'),
        ),
      ),
    );
  }
}
