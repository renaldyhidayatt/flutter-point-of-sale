import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/pages/helloworld.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    // Animation for the spinner rotation
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    // Timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      setState(() {
        // Set opacity to 0
        _opacity = 0;
      });
      // Wait for animation to complete before navigating
      Future.delayed(const Duration(milliseconds: 500), () {
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HelloWorldPage()), // Replace with your next screen
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterLogo(
                    size:
                        200, // Ukuran logo sama seperti width yang diatur sebelumnya
                  ),

                  // Logo
                  // Image.asset(
                  //   'assets/enggrang.png', // Replace with your logo path
                  //   width: 200,
                  // ),
                  const SizedBox(height: 20),
                  // Spinner
                  RotationTransition(
                    turns: _animation,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFF5AE16), width: 8),
                          right: BorderSide(
                              color: const Color.fromRGBO(255, 238, 0, 0.2),
                              width: 8),
                          bottom: BorderSide(
                              color: const Color.fromRGBO(255, 238, 0, 0.2),
                              width: 8),
                          left: BorderSide(
                              color: const Color.fromRGBO(255, 238, 0, 0.2),
                              width: 8),
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Loading text
                  _buildLoadingText(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build loading text with animation
  Widget _buildLoadingText() {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 1000),
      child: Text(
        'Loading...',
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
