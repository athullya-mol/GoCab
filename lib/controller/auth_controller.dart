import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocab/screens/login_screen.dart';

class AuthController extends GetxController {
  String userid = "";
  var verId = '';
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;
  phoneAuth(String phone, BuildContext context) async {
    try {
      credentials = null;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Completed");
          credentials = credential;
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        forceResendingToken: resendTokenId,
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.code} - ${e.message}");
          if (e.code == 'invalid-phone-number') {
            print("Invalid Number");
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid Phone Number')));
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Code Sent')));
          print("Code Sent");
          verId = verificationId;
          resendTokenId = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Auto retrieval timeout for $phone");
        },
      );
    } catch (e) {
      print("Error Occured $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error Occured")));
    }
  }

  verifyOtp(String otpNumber, BuildContext context) async {
    print("Otp Initialize");
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpNumber);
    print("Otp Called");

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("OTP Verified and User Signed In");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Verified and User Signed In")));
      Get.to(() => const LoginScreen());
    } catch (e) {
      print("Error during OTP verification: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error during OTP verification")));
    }
  }
}
