import 'package:commet_chat/features/registration/pages/basic_details_screen.dart';
import 'package:commet_chat/features/registration/pages/education_screen.dart';
import 'package:commet_chat/features/registration/pages/prfile_photo_screen.dart';
import 'package:commet_chat/features/registration/pages/select_profile_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes { basicDetailsScreen, educationScreen, profilePhotoScreen, selectProfileScreen,splashScreen, otpScreen, authenticationScreen,conversationScreen, chatScreen }

GoRouter goRouter = GoRouter(
  initialLocation: '/',
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
    )
    GoRoute(
      path: '/educationScreen',
      name: Routes.educationScreen.name,
      builder: (context, state) => EducationScreen(),
    ),
    GoRoute(
      path: '/profilePhotoScreen',
      name: Routes.profilePhotoScreen.name,
      builder: (context, state) => ProfilePhotoScreen(),
    ),
    GoRoute(
      path: '/selectProfileScreen',
      name: Routes.selectProfileScreen.name,
      builder: (context, state) => SelectProfileScreen(),
      ),
      GoRoute(
      path: "/conversation",
      name: Routes.conversationScreen.name,
      builder: (context, state) => ConversationsScreen(),
    ),
    GoRoute(
      path: "/chat",
      name: Routes.chatScreen.name,
      builder: (context, state) => ChatScreen(),
    ),

   ]




);
