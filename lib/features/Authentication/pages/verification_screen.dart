import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// BIG CHECK ICON
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_rounded,
                  color: Colors.green,
                  size: 70.sp,
                ),
              ),

              SizedBox(height: 28.h),

              /// MAIN TITLE
              Text(
                "Under Verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12.h),

              /// SMALL DESCRIPTION
              Text(
                "We’re reviewing your details.\nThis usually takes a few minutes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey[600],
                ),
              ),

              SizedBox(height: 35.h),

              /// LOADING INDICATOR
              SizedBox(
                width: 28.w,
                height: 28.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
