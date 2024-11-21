import 'package:chessgame/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorsConstants colors = ColorsConstants();

    return Scaffold(
      body: Stack(
        children: [
          // Upper section (with Chess Logo)
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: colors.backgroundDark,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Text(
                    "Chess Logo",
                    style: TextStyle(
                      fontSize: 30,
                      color: colors.backgroundLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Curved divider with ClipPath
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                color: colors.backgroundLight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 18,
                        color: colors.backgroundDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top-left corner of the container
    path.moveTo(0, 0);

    // First wave
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.4, // Control point
      size.width * 0.5,
      size.height * 0.1, // End point (lower part of the wave)
    );

    // Second wave
    path.quadraticBezierTo(
      size.width * 0.6, size.height * 0.02, // Control point
      size.width * 0.8,
      size.height * 0.15, // End point (lower part of the wave)
    );

    // Third wave that finishes higher on the right
    path.quadraticBezierTo(
      size.width * 0.9, size.height * 0.2, // Control point
      size.width, 0, // End point (higher part of the wave)
    );

    // Close the path at the bottom-right edge
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
