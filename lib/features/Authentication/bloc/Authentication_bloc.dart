import 'package:bloc/bloc.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/services/local_db_services.dart';
import 'package:commet_chat/core/services/tokens.dart';
import 'package:commet_chat/core/services/user.dart';
import 'package:commet_chat/features/Authentication/repository/Authentication_repository.dart';
import 'package:commet_chat/main.dart';
import 'package:equatable/equatable.dart';

part 'Authentication_event.dart';
part 'Authentication_state.dart';

enum AuthStatus { login, logout }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository repository;

  AuthStatus authStatus = AuthStatus.logout;

  String? phoneNo;

  AuthenticationBloc(this.repository) : super(AuthenticationInitial()) {
    on<AppHandelEvent>(_appHandelEvent);
    on<SendOtpEvent>(_sendOtpEvent);
    on<ValidateOtpEvent>(_validateOtpEvent);
    on<NavigateUserEvent>(_navigateUser);
    on<UpdateAuthStatus>((event, emit) {
      authStatus = event.status;

      if (authStatus == AuthStatus.login) {
        // TODO FOR WHEN USER LOGIN
      }

      if (authStatus == AuthStatus.logout) {
        // TODO WHEN USER LOGOUT
      }
    });
  }

  _appHandelEvent(AppHandelEvent event, emit) async {
    final isUserComesFirstTime = await LocalDbServices().isFirstTimeUSer();

    if (isUserComesFirstTime) {
      goRouter.goNamed(Routes.landingScreen.name);
      return;
    }

    final refreshToken = await Tokens.refreshToken;

    if (refreshToken != null) {
      try {
        await repository.refreshToken();
        await repository.getUserDetails();
        add(UpdateAuthStatus(status: AuthStatus.login));
        add(NavigateUserEvent());
      } catch (e) {
        goRouter.goNamed(Routes.authenticationScreen.name);
        return;
      }
    }
    goRouter.goNamed(Routes.authenticationScreen.name);
  }

  _sendOtpEvent(SendOtpEvent event, emit) async {
    phoneNo = event.phoneNo;
    emit(SendOtpEventLoadingState());
    try {
      await repository.sendOtp(event.phoneNo);
      emit(SendOtpEventSuccessState());
    } catch (e) {
      emit(SendOtpEventErrorState(error: e.toString()));
    }
  }

  _validateOtpEvent(ValidateOtpEvent event, emit) async {
    emit(ValidateOtpEventLoadingState());
    try {
      await repository.validateOtp(phoneNo: phoneNo, otp: event.otp);
      await repository.getUserDetails();
      add(UpdateAuthStatus(status: AuthStatus.login));
      add(NavigateUserEvent());
    } catch (e) {
      emit(ValidateOtpEventErrorState(error: e.toString()));
    }
  }

  _navigateUser(event, emit) {
    if (!User().registrationStatus) {
      goRouter.goNamed(Routes.basicDetailsScreen.name);
      return;
    } else if (!User().varificationStatus) {
      goRouter.goNamed(Routes.verificationScreen.name);
      return;
    } else {
      goRouter.goNamed(Routes.conversationScreen.name);
    }
  }
}
