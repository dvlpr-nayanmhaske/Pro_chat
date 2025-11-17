import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});
  TextEditingController numberField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 630.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/564x/6c/f4/bc/6cf4bcad33c920432681f08e68266573.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              30.heightBox,
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome To Reshimgathi",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: Fonts.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      "Please enter your whatsapp number to continue",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Fonts.medium,
                        color: Colors.grey,
                      ),
                    ),
                    20.heightBox,
                    TextFormField(
                      onChanged: (value) {},
                      controller: numberField,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16, right: 8),
                          child: Text(
                            "+91",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                        hintText: "Enter your Mobile Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
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
                            SendOtpEvent(phoneNo: numberField.text),
                          );
                        },
                        child:
                            BlocConsumer<
                              AuthenticationBloc,
                              AuthenticationState
                            >(
                              listener: (context, state) {
                                if (state is SendOtpEventSuccessState) {
                                  goRouter.goNamed(Routes.otpScreen.name);
                                }

                                if (state is SendOtpEventErrorState) {
                                  // HANDLE ERROR
                                }
                              },
                              builder: (context, state) {
                                return state is SendOtpEventLoadingState
                                    ? Center(child: CircularProgressIndicator())
                                    : Text("Continue");
                              },
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
