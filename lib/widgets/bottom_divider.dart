import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gocab/utils/app_colors.dart';

Widget bottomDivider() {
  return Container(
    width: Get.width * 0.6,
    height: 20,
    padding: const EdgeInsets.only(left: 50, right: 50),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: AppColors.blackColor,
    ),
    child: const Divider(
      thickness: 2,
    ),
  );
}
