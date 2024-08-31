import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {}); // Durasi splash screen
    Navigator.pushReplacementNamed(context, '/home'); // Navigasi ke halaman utama
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Warna background splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart, // Ganti dengan logo atau ikon Anda
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
