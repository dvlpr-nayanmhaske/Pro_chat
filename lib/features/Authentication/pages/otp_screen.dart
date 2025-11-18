import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController pinField = TextEditingController();

  late final AuthenticationBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<AuthenticationBloc>();
  }

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
              "We've sent a 4 digit OTP to +91 ${bloc.phoneNo}",
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
                  locator<AuthenticationBloc>().add(
                    ValidateOtpEvent(otp: pinField.text),
                  );
                },
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is ValidateOtpEventSuccessState) {
                      goRouter.goNamed(Routes.basicDetailsScreen.name);
                    }
                    if (state is ValidateOtpEventErrorState) {
                      print(state.error);
                    }
                  },
                  builder: (context, state) {
                    return state is ValidateOtpEventLoadingState
                        ? CircularProgressIndicator()
                        : Text("Verify & Continue");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
