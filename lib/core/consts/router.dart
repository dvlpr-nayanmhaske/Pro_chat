import 'package:commet_chat/features/registration/pages/basic_details_screen.dart';
import 'package:commet_chat/features/registration/pages/education_screen.dart';
import 'package:commet_chat/features/registration/pages/prfile_photo_screen.dart';
import 'package:commet_chat/features/registration/pages/select_profile_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes { basicDetailsScreen, educationScreen, profilePhotoScreen, selectProfileScreen }

GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
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
  ],
);
