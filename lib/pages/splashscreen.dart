import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_application_1/pages/helloworld.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _spinnerController;
  late AnimationController _textController;
  late Animation<double> _spinnerAnimation;
  late Animation<int> _textAnimation;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    // Animation for the spinner rotation
    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _spinnerAnimation = Tween(begin: 0.0, end: 1.0).animate(_spinnerController);

    // Animation for the loading text
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _textAnimation = IntTween(begin: 0, end: 3).animate(_textController);

    // Timer to navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 0;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelloWorldPage()),
        );
      });
    });
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 200),
              const SizedBox(height: 20),
              RotationTransition(
                turns: _spinnerAnimation,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF5AE16)),
                  strokeWidth: 4,
                ),
              ),
              const SizedBox(height: 20),
              _buildLoadingText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingText() {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (BuildContext context, Widget? child) {
        return Text(
          'Loading' + '.' * (_textAnimation.value),
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        );
      },
    );
  }
}