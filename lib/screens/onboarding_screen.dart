import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gocab/screens/driver_pin_verify_screen.dart';
import 'package:gocab/screens/verify_otp_screen.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatelessWidget {
  final String pin;

  const OnBoardingScreen({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.amberColor,
      body: Center(
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
                    fontSize: 45, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              width: Get.width * 0.8,
              height: Get.height * 0.4,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign In As",
                    style: GoogleFonts.poppins(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VerifyOtpScreen()));
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColors.blackColor,
                      ),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 70)),
                    ),
                    child: Text(
                      "Customer",
                      style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DriverVerificationScreen(pin: pin)));
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColors.blackColor,
                      ),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 20, horizontal: 90)),
                    ),
                    child: Text(
                      "Driver",
                      style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
