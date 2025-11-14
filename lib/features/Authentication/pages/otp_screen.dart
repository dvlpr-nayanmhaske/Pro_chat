import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  TextEditingController pinField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.heightBox,
            IconButton.filled(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primary),
              ),
              onPressed: () {
                goRouter.pop();
              },
              icon: Icon(Icons.arrow_back),
            ),
            50.heightBox,
            Text(
              "Verify Your Number",
              style: TextStyle(
                fontSize: 24.sp,
                fontFamily: Fonts.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "We've sent a 4 digit OTP to +91 93705 18036",
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: Fonts.regular,
                color: Colors.black.withOpacity(0.80),
              ),
            ),
            30.heightBox,
            SafeArea(
              child: Pinput(
                controller: pinField,

                length: 4,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 80,
                  height: 80,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    color: Colors.white,
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    color: AppColors.primary.withOpacity(0.08),
                  ),
                ),
                showCursor: true,
              ),
            ),
            20.heightBox,
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                onPressed: () {
                  goRouter.goNamed(Routes.basicDetailsScreen.name);
                },
                child: Text("Verify & Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
