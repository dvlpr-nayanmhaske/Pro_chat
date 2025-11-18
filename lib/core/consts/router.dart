import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/features/Authentication/pages/Authentication_screen.dart';
import 'package:commet_chat/features/Authentication/pages/otp_screen.dart';
import 'package:commet_chat/features/Authentication/pages/landing_screen.dart';
import 'package:commet_chat/features/Authentication/pages/splash_screen.dart';
import 'package:commet_chat/features/Authentication/pages/verification_screen.dart';
import 'package:commet_chat/features/chat/bloc/chat_bloc.dart';
import 'package:commet_chat/features/chat/pages/chat_screen.dart';
import 'package:commet_chat/features/chat/repository/chat_repository.dart';
import 'package:commet_chat/features/conversations/pages/conversations_screen.dart';
import 'package:commet_chat/features/registration/pages/basic_details_screen.dart';
import 'package:commet_chat/features/registration/pages/education_screen.dart';
import 'package:commet_chat/features/registration/pages/prfile_photo_screen.dart';
import 'package:commet_chat/features/registration/pages/select_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  basicDetailsScreen,
  educationScreen,
  profilePhotoScreen,
  selectProfileScreen,
  splashScreen,
  landingScreen,
  otpScreen,
  authenticationScreen,
  conversationScreen,
  chatScreen,
  verificationScreen,
}

GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: "/",
      name: Routes.splashScreen.name,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/landingScreen",
      name: Routes.landingScreen.name,
      builder: (context, state) => LandingScreen(),
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
    GoRoute(
      path: "/verificationScreen",
      name: Routes.verificationScreen.name,
      builder: (context, state) => VerificationScreen(),
    ),
    GoRoute(
      path: "/basicDetailsScreen",
      name: Routes.basicDetailsScreen.name,
      builder: (context, state) => BasicDetailsScreen(),
    ),

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
      path: "/chat/:id",
      name: Routes.chatScreen.name,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            ChatBloc(ChatRepository(apiClient: locator<ApiClient>())),
        child: ChatScreen(conversationId: state.pathParameters['id'] as String),
      ),
    ),
  ],
);
