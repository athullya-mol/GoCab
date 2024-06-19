import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:pinput/pinput.dart';

class DriverVerificationScreen extends StatefulWidget {
  final String pin;

  const DriverVerificationScreen({super.key, required this.pin});

  @override
  State<DriverVerificationScreen> createState() =>
      _DriverVerificationScreenState();
}

class _DriverVerificationScreenState extends State<DriverVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  String? errorMessage;

  void _verifyPin() {
    if (_pinController.text == widget.pin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RideStartedScreen(),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Incorrect PIN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 45,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: AppColors.whiteColor,
      ),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter PIN to Start Ride',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Pinput(
                controller: _pinController,
                keyboardType: TextInputType.number,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 16),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: AppColors.amberColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                        offset: Offset(0, 3),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                ),
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   controller.setText(value);
                // },
                showCursor: true,
                cursor: cursor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.blackColor),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 70))),
              onPressed: _verifyPin,
              child: Text(
                "Verify",
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RideStartedScreen extends StatelessWidget {
  const RideStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Text(
          'Ride Started!',
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
