import 'dart:ui'; // Import tambahan untuk ImageFilter

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'homescreen.dart'; // Import HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/herbal_logo.png', // Ganti dengan path logo Anda
                  height: 200.0,
                  width: 200.0,
                ),
              ),
              const SizedBox(height: 20.0),
              DefaultTextStyle(
                style: const TextStyle(
                  fontFamily: 'Pacifico', // Menggunakan font yang lebih menarik
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Edukasi Ramuan Herbal Tradisional'),
                    TypewriterAnimatedText('Belajar dan Nikmati Khasiatnya'),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
              const SizedBox(height: 50.0),
              ElevatedButton.icon(
                onPressed: _navigateToHome,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Mulai'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
