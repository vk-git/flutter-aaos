import 'package:flutter/material.dart';
import 'package:fluttersample/constants.dart';

import '../home_screen.dart';
import 'gears.dart';

class GearAndBattery extends StatelessWidget {
  const GearAndBattery({
    super.key,
    required this.constraints,
    required this.selectedGearIndex
  });

  final BoxConstraints constraints;
  final int selectedGearIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey.withOpacity(0.15),
      width: constraints.maxWidth * 0.74,
      height: constraints.maxHeight * 0.22,
      child: LayoutBuilder(
        builder: (context, gearConstraints) => Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: GearPrinter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Gears(selectedGearIndex: selectedGearIndex),
                  Text.rich(
                    TextSpan(
                      text: "Rest. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      children: const [
                        TextSpan(
                          text: "465km",
                          style: TextStyle(
                            color: Color(0xFF77C000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: gearConstraints.maxWidth * 0.72,
                      child: Row(
                        children: [
                          Text(
                            "E",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: SizedBox(
                              height: 8,
                              child: ClipPath(
                                clipper: BatteryStatusCliper(),
                                child: CustomPaint(
                                  painter: DashLinePainter(progress: 10),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "F",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF77C000),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: gearConstraints.maxHeight * 0.10,
              left: gearConstraints.maxWidth * 0.16,
              width: gearConstraints.maxWidth * 0.17,
              height: gearConstraints.maxHeight * 0.38,
              child: CustomPaint(
                painter: AvgWattPerKmPrinter(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: gearConstraints.maxWidth * 0.025),
                    Text(
                      "Avg. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "11.3 L/km",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: gearConstraints.maxHeight * 0.10,
              right: gearConstraints.maxWidth * 0.16,
              width: gearConstraints.maxWidth * 0.17,
              height: gearConstraints.maxHeight * 0.38,
              child: CustomPaint(
                painter: OdoPrinter(),
                child: Row(
                  children: [
                    Text(
                      "ODO. ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      "6666.6km",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BatteryStatusCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.05, 0)
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class AvgWattPerKmPrinter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    // paint.shader = LinearGradient(colors: colors)
    const double strokeWidth = 4;
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.27, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.27, strokeWidth);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OdoPrinter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    // paint.shader = LinearGradient(colors: colors)
    const double strokeWidth = 4;
    Path path = Path()
      ..lineTo(size.width * 0.73, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.73, strokeWidth);
    // ..lineTo(size.width, 0);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}