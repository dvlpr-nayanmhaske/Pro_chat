import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectProfileScreen extends StatelessWidget {
  const SelectProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();

    final List<String> sampleUrls = [
      "https://images.unsplash.com/photo-1517841905240-472988babdf9",
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
      "https://images.unsplash.com/photo-1502685104226-ee32379fefbe",
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            80.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Profile Picture',
                    style: TextStyle(fontSize: 20.sp, fontFamily: Fonts.bold),
                  ),
                  12.heightBox,
                  Text(
                    'Your photo will be manually verified for authenticity.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),

            20.heightBox,

            /// ---------------------------------
            ///  IMAGE SELECTOR WITH TICK MARK
            /// ---------------------------------
            SizedBox(
              height: 400.h,
              child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: sampleUrls.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final url = sampleUrls[index];
                      final isSelected = bloc.selectedProfileImage == url;

                      return GestureDetector(
                        onTap: () {
                          bloc.add(SelectProfileImageEvent(url));
                        },

                        child: Stack(
                          children: [
                            Container(
                              width: 340.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.grey.withOpacity(0.3),
                                  width: 2.2,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            /// CHECKMARK
                            if (isSelected)
                              Positioned(
                                right: 12,
                                top: 12,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            20.heightBox,

            Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        goRouter.pushNamed(Routes.basicDetailsScreen.name);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        elevation: WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: Fonts.regular,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  16.widthBox,
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (bloc.selectedProfileImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select an image")),
                          );
                          return;
                        }
                        goRouter.goNamed(Routes.selectProfileScreen.name);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.primary,
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: Fonts.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            24.heightBox,
          ],
        ),
      ),
    );
  }
}
