import 'package:commet_chat/core/consts/urls.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthenticationBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = locator<AuthenticationBloc>();

    Future.delayed(Duration(seconds: 2), () {
      bloc.add(AppHandelEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
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
