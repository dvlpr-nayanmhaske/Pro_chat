import 'package:commet_chat/core/consts/extension.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Fullscreen background image
          Positioned.fill(
            child: Image.network(
              "https://static.toiimg.com/thumb/100764493/100764493.jpg?height=746&width=420&resizemode=76&imgsize=78158",
              fit: BoxFit.cover,
            ),
          ),

          /// Add a subtle color overlay for text visibility
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          /// Centered content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "रेशमगाठी मराठी मॅट्रिमोनी",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 6.r,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  10.heightBox,
                  Text(
                    "रेशमबंधांच्या नव्या प्रवासाला सुरुवात करा",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          /// Bottom gesture hint text
          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  goRouter.goNamed(Routes.authenticationScreen.name);
                },
                child: Text(
                  "स्पर्श करा पुढे जाण्यासाठी 👆",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
