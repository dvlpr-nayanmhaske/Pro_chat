import 'package:commet_chat/features/Authentication/pages/Authentication_screen.dart';
import 'package:commet_chat/features/Authentication/pages/otp_screen.dart';
import 'package:commet_chat/features/Authentication/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes { splashScreen, otpScreen, authenticationScreen }

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: Routes.splashScreen.name,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/authenticationScrren",
      name: Routes.authenticationScreen.name,
      builder: (context, state) => AuthenticationScreen(),
    ),
    GoRoute(
      path: "/otpScreen",
      name: Routes.otpScreen.name,
      builder: (context, state) => OtpScreen(),
    ),
  ],
);
