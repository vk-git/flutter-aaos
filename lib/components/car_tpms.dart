import 'package:flutter/material.dart';

class CarTpms extends StatelessWidget {
  const CarTpms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Tire Pressure PSI",
          style: TextStyle(fontSize: 18, color: Colors.white54),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Image.asset(
              "assets/images/car_top.png",
              fit: BoxFit.cover,
              color: Colors.white70,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.red);
              },
            ),
            const Positioned(
              top: 20,
              left: 16,
              child: Text(
                "35",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            const Positioned(
              top: 20,
              right: 16,
              child: Text(
                "35",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            const Positioned(
              bottom: 20,
              right: 16,
              child: Text(
                "35",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),
            const Positioned(
              bottom: 20,
              left: 16,
              child: Text(
                "30",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    );
  }
}
