import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';


Widget vectorDesignIntro() {
  return ClipPath(
    clipper: UnequalCurveClipper(),
    child: Container(
      width: Get.width,
      height: Get.height * 0.40,
      decoration: const BoxDecoration(
        color: AppColors.amberColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/goCab.svg',
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            Text("GoCab",
                style: GoogleFonts.poppins(
                    fontSize: 45, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    ),
  );
}

class UnequalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    var secondEndPoint = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
