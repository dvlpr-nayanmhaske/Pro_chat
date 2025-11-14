import 'package:commet_chat/core/consts/colours.dart';
import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/fonts.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/conversations/bloc/conversations_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationsScreen extends StatelessWidget {
  ConversationsScreen({super.key});

  List optionals = ["All", "Unread", "Imporatant"];

  showBottomSheet(contex) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: contex,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            32.heightBox,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "USERS",
                style: TextStyle(fontFamily: Fonts.semiBold, fontSize: 24.sp),
              ),
            ),
            16.heightBox,
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 38.r,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    12.widthBox,
                    SizedBox(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aadesh",
                            style: TextStyle(
                              fontFamily: Fonts.medium,
                              fontSize: 18.sp,
                            ),
                          ),
                          165.widthBox,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          "Messages",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontFamily: Fonts.semiBold,
          ),
        ),
        actions: [
          IconButton.filled(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primary),
            ),

            onPressed: () {
              showBottomSheet(context);
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  fontFamily: Fonts.medium,
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
                cursorColor: Colors.grey.shade400,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
              ),
              24.heightBox,
              BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  final bloc = context.read<ConversationsBloc>();
                  return Row(
                    children: List.generate(
                      optionals.length,
                      (index) => GestureDetector(
                        onTap: () {
                          bloc.add(SelectedTabEvent(index: index));
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.h),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: index == bloc.selected
                                ? AppColors.primary
                                : AppColors.lightPrimary,
                            // border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(20.r),
                          ),

                          child: Text(
                            optionals[index],
                            style: TextStyle(
                              fontFamily: Fonts.medium,
                              fontSize: 14.sp,
                              color: index == bloc.selected
                                  ? Colors.white
                                  : AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              24.heightBox,
              GestureDetector(
                onTap: () {
                  goRouter.pushNamed(Routes.chatScreen.name);
                },
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: 38.r,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        12.widthBox,
                        SizedBox(
                          height: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(
                                    "Aadesh",
                                    style: TextStyle(
                                      fontFamily: Fonts.medium,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  165.widthBox,
                                  Text(
                                    "9:58",
                                    style: TextStyle(
                                      fontFamily: Fonts.regular,
                                      fontSize: 18.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "hello",
                                style: TextStyle(
                                  fontFamily: Fonts.regular,
                                  fontSize: 18.sp,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(width: 280.h, child: Divider()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
