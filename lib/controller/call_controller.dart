import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallController extends GetxController {
  final String customerCareNumber = 'ENTER CUSTOMER CARE NUMBER';
  final String driverNumber = 'ENTER DRIVER NUMBER';
  RxBool callForwarded = false.obs;

  Future<void> initiateCall() async {
    bool? callMade =
        await FlutterPhoneDirectCaller.callNumber(customerCareNumber);
    if (callMade != null && callMade) {
      print("Call initiated to customer care.");
      await _startCallWithDriver();
    } else {
      print("Failed to initiate call to customer care.");
    }
  }

  Future<void> _startCallWithDriver() async {
    bool? callMade = await FlutterPhoneDirectCaller.callNumber(driverNumber);
    if (callMade != null && callMade) {
      print("Call initiated to driver.");
    } else {
      print("Failed to initiate call to driver.");
    }
  }
}
