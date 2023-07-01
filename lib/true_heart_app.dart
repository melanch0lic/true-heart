import 'package:flutter/material.dart';

class TrueHeartApp extends StatelessWidget {
  const TrueHeartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Heart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Center(child: Text('True Heart')),
    );
  }
}
