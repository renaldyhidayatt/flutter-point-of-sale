import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/auth/register.dart';
import 'package:flutter_application_1/pages/dashboard.dart';
import 'package:flutter_application_1/pages/helloworld.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/notelist.dart';
import 'package:flutter_application_1/pages/pointofsale.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/splashscreen.dart'; // Import splash screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation',
      debugShowCheckedModeBanner: false, // Disable the debug banner

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Splash screen sebagai halaman awal
      routes: {
        '/': (context) => SplashScreen(), 
        '/home': (context) => HelloWorldPage(),
        '/pos': (context) => PointOfSaleScreen(),
        '/login': (context) => LoginPage(),
        '/register':(context) => RegisterPage(),
        '/profile': (context) => ProfileScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/notes': (context) => NoteListScreen(),
      },
    );
  }
}