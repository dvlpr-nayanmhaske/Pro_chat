import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/list.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicDetailsScreen extends StatelessWidget {
  BasicDetailsScreen({super.key});

  TextEditingController firstnameField = TextEditingController();
  TextEditingController lastnameField = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        width: double.infinity,
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              80.heightBox,
              Text(
                'Basic Details',
                style: TextStyle(fontSize: 24.sp, fontFamily: Fonts.bold),
              ),
              12.heightBox,
              Text(
                'Let s know few things about you',
                style: TextStyle(fontSize: 16.sp),
              ),
              12.heightBox,
              Text('Gender', style: TextStyle(fontSize: 16.sp)),
              8.heightBox,
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return Wrap(
                    children: List.generate(
                      genderList.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            bloc.add(SelectGenderEvent(genderList[index]));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              color: bloc.selectedGender == genderList[index]
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: bloc.selectedGender == genderList[index]
                                    ? AppColors.primary
                                    : Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              genderList[index],
                              style: TextStyle(
                                color: bloc.selectedGender == genderList[index]
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Row(
              //   children: [
              //     FilledButton(
              //       onPressed: () {},
              //       style: ButtonStyle(
              //         backgroundColor: WidgetStatePropertyAll(
              //           AppColors.primary,
              //         ),
              //       ),
              //       child: Text('Male'),
              //     ),
              //     12.widthBox,
              //     FilledButton(
              //       onPressed: () {},
              //       style: ButtonStyle(
              //         backgroundColor: WidgetStatePropertyAll(
              //           AppColors.primary,
              //         ),
              //       ),
              //       child: Text('Female'),
              //     ),
              //   ],
              // ),
              16.heightBox,
              customTextField(
                validator: (value) => customTextValidator(value),
                label: "First Name",
                controller: firstnameField,
              ),
              8.heightBox,
              customTextField(
                validator: (value) => customTextValidator(value),
                label: "last name",
                controller: lastnameField,
              ),
              8.heightBox,
              customTextField(label: "Date Of Birth"),
              8.heightBox,
              customTextField(label: "Height"),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 42.h,
                child: FilledButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      goRouter.goNamed(Routes.educationScreen.name);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 20.sp, fontFamily: Fonts.bold),
                  ),
                ),
              ),
              24.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

TextFormField customTextField({
  label,
  controller,
  onTap,
  readOnly = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    readOnly: readOnly,
    onTap: onTap,
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      label: Text("$label", style: TextStyle(color: AppColors.primary)),

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.50)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
  );
}

String? customTextValidator(dynamic value) {
  if (value == null || value.toString().trim().isEmpty) {
    return "This field is required";
  }
  return null;
}
