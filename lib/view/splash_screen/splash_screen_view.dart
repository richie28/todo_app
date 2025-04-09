
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/view/home_screen/home_screen_view.dart';


class SplashScreen extends StatelessWidget {
  final Color primaryColor = const Color(0xFF6C63FF);

  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => HomeScreenView());
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/app_logo.svg',
              height: Get.height *0.2,

            ),
            SizedBox(height: 20.h),
            Text(
              'To-Do App',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
