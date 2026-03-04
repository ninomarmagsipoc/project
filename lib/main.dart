import 'package:flutter/material.dart';
import 'package:project/dashboard.dart';
import 'package:project/screen/signin.dart';
import 'package:project/service/anime.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      initialRoute: '/',
      routes: {
        '/signin': (context) => const SignIn(),
        '/dashboard': (context) => const Dashboard(),
        '/anime': (context) => const AnimePage(),
      },
    );
  }
}
