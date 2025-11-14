import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/features/conversations/bloc/conversations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:commet_chat/features/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CometChat());
}

class CometChat extends StatelessWidget {
  const CometChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ConversationsBloc()),
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
