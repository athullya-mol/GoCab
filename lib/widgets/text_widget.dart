import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({required String text}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Text(text,
        style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
  );
}
