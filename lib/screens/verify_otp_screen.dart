import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocab/controller/auth_controller.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:gocab/widgets/otp_pinput_widget.dart';
import 'package:gocab/widgets/text_widget.dart';
import 'package:gocab/widgets/vector_design_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  Country countryPicked = CountryParser.parseCountryCode("IN");
  final TextEditingController _phoneController = TextEditingController();
  AuthController authController = Get.put(AuthController());
  String phoneNumber = "";

  onPhoneNoSubmit(String? phone) {
    if (phone == null || phone.isEmpty) {
      print("Phone number is empty or null");
      return;
    }

    phoneNumber = '+${countryPicked.phoneCode}$phone';
    print("Formatted phone number: $phoneNumber");

    if (phoneNumber.isNotEmpty) {
      authController.phoneAuth(phoneNumber,context);
    } else {
      print("Phone number is empty after formatting");
    }
  }

  void showPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
          bottomSheetHeight: MediaQuery.of(context).size.height * 0.3),
      onSelect: (country) {
        setState(() {
          countryPicked = country;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              vectorDesignIntro(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      textWidget(text: "Hi, Welcome to GoCab"),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "We'll send you an One Time Password To Your Mobile Number",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blackColor.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3)
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: showPicker,
                                  child: Center(
                                    child: Text(
                                        '${countryPicked.flagEmoji} +${countryPicked.phoneCode}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )),
                            Container(
                              width: 2,
                              height: 55,
                              color: AppColors.greyColor,
                            ),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: _phoneController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Mobile Number";
                                      }
                                      if (value.length != 10) {
                                        return "Invalid Mobile Number";
                                      }
                                      return null;
                                    },
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter your Mobile Number",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        suffix: TextButton(
                                          onPressed: () {
                                            onPhoneNoSubmit(
                                                _phoneController.text);
                                          },
                                          child: Text(
                                            "Send OTP",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        )),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enter Your 4-digit Code",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const RoundedWithShadow(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Resend Code\t',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "in 10 seconds",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500))
                      ])),
                      const SizedBox(
                        height: 40,
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text:
                                'By creating an account, you want to agree our ',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: "Terms & Conditions",
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ]))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
