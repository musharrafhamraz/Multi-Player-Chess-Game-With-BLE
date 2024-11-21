import 'package:chessgame/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorsConstants colors = ColorsConstants();
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: colors.backgroundDark,
          ),
          // Curved Top Section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WavyClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                color: colors.backgroundLight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Iconsax.grid_2, color: colors.iconColor),
                          Row(
                            children: [
                              Icon(Iconsax.notification,
                                  color: colors.iconColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Iconsax.close_circle,
                                  color: colors.iconColor),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Player Info
                      const PlayerInfo(
                        imagePath: 'assets/pic.jpeg',
                        playerName: 'Musharraf',
                        playerType: 'Solo Player',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Curved Bottom Section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomWavyClipper(),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: colors.backgroundLight,
                  child: const PlayerInfo(
                      playerName: 'Farhan',
                      playerType: 'Solo',
                      imagePath: 'assets/pic.jpeg')),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerInfo extends StatelessWidget {
  final String playerName;
  final String playerType;
  final String imagePath;
  const PlayerInfo({
    super.key,
    required this.playerName,
    required this.playerType,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(imagePath), // Replace with your image
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              playerType,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

// Wavy CustomClipper for Top Curve
class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.9,
      size.width * 0.55,
      size.height * 0.55,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.35,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// // Wavy CustomClipper for Bottom Curve
// class BottomWavyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 5); // Start at the top-left corner of the container
//     path.quadraticBezierTo(
//       size.width * 0.25,
//       size.height * -0.12, // First control point (adjusted for upper curve)
//       size.width * 0.45,
//       size.height * 0.1, // First endpoint
//     );
//     path.quadraticBezierTo(
//       size.width * 0.75,
//       size.height * 0.8, // Second control point
//       size.width, 0, // Second endpoint
//     );
//     path.lineTo(size.width, size.height); // Bottom-right corner
//     path.lineTo(0, size.height); // Bottom-left corner
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

class BottomWavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0); // Start at the top-left corner
    path.quadraticBezierTo(
      size.width / 4,
      -size.height / 8, // Adjust the control point for the upper curve
      size.width / 2,
      size.height / 4, // Adjust the endpoint
    );
    path.quadraticBezierTo(
      size.width * 3 / 4,
      size.height / 2, // Adjust the control point for the lower curve
      size.width, 0, // End at the bottom-right corner
    );
    path.lineTo(size.width, size.height); // Bottom-right corner
    path.lineTo(0, size.height); // Bottom-left corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
