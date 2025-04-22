import 'package:flutter/material.dart';
import 'package:fluttersample/constants.dart';

class Gears extends StatefulWidget {
  Gears({
    Key? key,
    this.gears = const ["S", "D", "N", "R", "P"],
    required this.selectedGearIndex
  }) : super(key: key);

  final List<String> gears;
  int selectedGearIndex = 1;


  @override
  State<Gears> createState() => _GearsState();
}

class _GearsState extends State<Gears> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.gears.length,
                    (index) => Text(
                  widget.gears[index],
                  style: TextStyle(
                    color: index == widget.selectedGearIndex
                        ? primaryColor
                        : Colors.white.withOpacity(0.16),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}