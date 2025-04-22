import 'package:flutter/material.dart';

class CarDte extends StatelessWidget {
  const CarDte({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0),
            ],
          ).createShader(
            Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "DTE - ",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500,
                  height: 0.9),
              ),
              Text(
                "200",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  height: 0.9,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.white),
                ),
              ),
              child: Image.asset(
                "assets/images/car_side.png",
                fit: BoxFit.cover,
                color: Colors.white70,
                height: 30,
                width: 70,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.red);
                },
              ),
            ),
            const Text(
              "_",
              style: TextStyle(fontSize: 40,  height: 0.9,color: Colors.white54),
            ),
            const Text(
              "_",
              style: TextStyle(fontSize: 40, height: 0.9, color: Colors.white54),
            ),
            const Text(
              "_",
              style: TextStyle(fontSize: 40,  height: 0.9,color: Colors.white54),
            ),
            Image.asset(
              "assets/images/gas_station.png",
              fit: BoxFit.cover,
              color: Colors.white70,
              height: 34,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.red);
              },
            ),
          ],
        )
      ],
    );
  }
}
