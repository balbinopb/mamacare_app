
import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.lineTo(0, size.height - 60);

    // Control point toward the LEFT, and Y deeper for a left-heavy dip
    path.quadraticBezierTo(
      size.width * 0.3,       // Closer to the left
      size.height + 10,       // Dip lower on the left
      size.width,
      size.height - 90,       // End point: bottom-right
    );

    // Line to top-right and close path
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
