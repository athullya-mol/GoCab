import 'package:flutter/material.dart';
import 'package:gocab/controller/call_controller.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class DriverDetailsWidget extends StatelessWidget {
  DriverDetailsWidget({super.key});
  final CallController callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.width,
      height: Get.height * 0.15,
      decoration: const BoxDecoration(
        color: AppColors.amberColor,
      ),
      child: Center(
        child: ListTile(
          leading: const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFT4ZB0ukW3B5EMHBcK7E8yMZOsmntZoqc9w&s"),
          ),
          title: Text(
            "Driver Name",
            style: GoogleFonts.poppins(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "Honda City",
            style: GoogleFonts.poppins(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          trailing: IconButton(
            onPressed: () {
              callController.initiateCall();
            },
            icon: const Icon(
              Icons.phone,
              color: AppColors.whiteColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
