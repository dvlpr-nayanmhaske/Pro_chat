import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/consts/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () => goRouter.goNamed(Routes.landingScreen.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LOGO
            Image.asset(
              Urls.logo,
              width: double.infinity,
              height: 500.w,
              fit: BoxFit.contain,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
