import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttersample/constants.dart';

import '../common_widgets/soft_button.dart';
import '../constants.dart';

class SongCircleContainer extends StatelessWidget {
  const SongCircleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularSoftButton(
                padding: 0,
                radius: 90,
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        "https://sm.mashable.com/t/mashable_in/photo/default/arijit-singh-copy_ddzh.1248.jpg",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: Colors.red);
                        },
                      )),
                ),
              ),
              SizedBox(
                height: 210,
                width: 210,
                child: Transform.flip(
                  flipX: true,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        backgroundColor: primaryColor.withOpacity(0.3),
                        value: 10,
                        strokeWidth: 7,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => {},
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: primaryColor,
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeInOutBack,
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          "assets/icons/prev.svg",
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: () => {},
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: primaryColor,
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeInOutBack,
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/play.svg",
                        color: Colors.white,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              GestureDetector(
                onTap: () => {},
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: primaryColor,
                  child: AnimatedSwitcher(
                    switchInCurve: Curves.easeInOutBack,
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 300),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/next.svg",
                        color: Colors.white,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//https://www.myrouteonline.com/wp-content/uploads/2024/01/Create-a-Route-on-Google-Maps-800-x-533-px.png