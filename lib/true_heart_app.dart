import 'package:flutter/material.dart';
import 'package:true_heart_app/pages/login_page/login_page.dart';

class TrueHeartApp extends StatelessWidget {
  const TrueHeartApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Heart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
