import 'package:flutter/material.dart';

import '../model/car_data.dart';

class WarningLights extends StatelessWidget {
  const WarningLights({
    super.key,
    required this.constraints,
    required this.cardData
  });

  final BoxConstraints constraints;
  final CarData cardData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth * 0.25,
      height: constraints.maxHeight * 0.11,
      child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleMedium!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/car_oil.png",
                color: Colors.white12,
                width: 40,
                height: 40,
              ),
              Image.asset(
                "assets/images/car_coolant.png",
                color: Colors.white12,
                width: 40,
                height: 40,
              ),
              Image.asset(
                "assets/images/car_engine.png",
                color: Colors.white12,
                width: 40,
                height: 40,
              ),
              Image.asset(
                "assets/images/car_battery.png",
                color: Colors.white12,
                width: 40,
                height: 40,
              ),
              Image.asset(
                "assets/images/parking_brake.png",
                color: cardData.parkingBrake == true ? Colors.red : Colors.white12,
                width: 40,
                height: 40,
              ),
            ],
          )),
    );
  }
}
