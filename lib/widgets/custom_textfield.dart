import 'package:flutter/material.dart';
import 'package:gocab/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    {ValueChanged<String>? onChanged,
    required String text,
    required TextEditingController controller}) {
  return Container(
    width: double.infinity,
    height: 55,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          spreadRadius: 3,
          blurRadius: 3,
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      cursorColor: AppColors.blackColor,
      cursorWidth: 2,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: text,
        prefixIcon: const Icon(
          Icons.location_on,
          color: AppColors.blackColor,
        ),
      ),
      onChanged: onChanged,
    ),
  );
}
