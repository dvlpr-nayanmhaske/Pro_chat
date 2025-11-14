import 'dart:io';

import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePhotoScreen extends StatefulWidget {
  const ProfilePhotoScreen({super.key});

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  bool _imageError = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            80.heightBox,
            Text(
              'Upload Profile Photos',
              style: TextStyle(fontSize: 20.sp, fontFamily: Fonts.bold),
            ),
            12.heightBox,
            Text(
              'Your photo will be manually verified for authencity.',
              style: TextStyle(fontSize: 14.sp),
            ),
            20.heightBox,

            /// FIXED: Wrap photo logic in BlocBuilder
            BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                if (bloc.images.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bloc.add(PickImageEvent());
                        },
                        child: DottedBorder(
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 40,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Upload image or drag & drop',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Supported formats: JPG, PNG, SVG',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_imageError)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "This field is required",
                            style: TextStyle(
                              color: Colors.red[700],
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                    itemCount: bloc.images.length < 6
                        ? bloc.images.length + 1
                        : 6,
                    itemBuilder: (context, index) => index == bloc.images.length
                        ? GestureDetector(
                            onTap: () {
                              bloc.add(PickImageEvent());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 42,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(File(bloc.images[index])),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              Positioned(
                                left: 80,
                                top: -20,
                                child: IconButton(
                                  onPressed: () {
                                    bloc.add(DeleteImageEvent(index: index));
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  );
                }
              },
            ),
            Spacer(),
            SizedBox(
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
