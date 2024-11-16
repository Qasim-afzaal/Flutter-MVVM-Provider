import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.purple,
      child: const Column(
        children: [
          Text(
            "Splash Screen",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }
}
