import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:commet_chat/features/conversations/bloc/conversations_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';

void main() {
  setupLocator();
  runApp(CometChat());
}

class CometChat extends StatelessWidget {
  CometChat({super.key});

  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: locator<AuthenticationBloc>()),
            BlocProvider.value(value: locator<ConversationsBloc>()),

            BlocProvider(create: (_) => RegistrationBloc()),
          ],
          child: MaterialApp.router(
            routerConfig: goRouter,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
