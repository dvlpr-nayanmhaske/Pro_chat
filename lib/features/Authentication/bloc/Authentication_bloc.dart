import 'package:bloc/bloc.dart';
import 'package:commet_chat/core/consts/router.dart';
import 'package:commet_chat/core/services/local_db_services.dart';

import 'package:commet_chat/features/Authentication/repository/Authentication_repository.dart';

import 'package:equatable/equatable.dart';

part 'Authentication_event.dart';
part 'Authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository repository;

  String? phoneNo;

  AuthenticationBloc(this.repository) : super(AuthenticationInitial()) {
    on<AppHandelEvent>(_appHandelEvent);
    on<SendOtpEvent>(_sendOtpEvent);
    on<ValidateOtpEvent>(_validateOtpEvent);
  }

  _appHandelEvent(AppHandelEvent event, emit) async {
    if (await LocalDbServices().isFirstTimeUSer()) {
      goRouter.goNamed(Routes.landingScreen.name);
    } else {
      goRouter.goNamed(Routes.authenticationScreen.name);
    }
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
      emit(ValidateOtpEventSuccessState());
    } catch (e) {
      emit(ValidateOtpEventErrorState(error: e.toString()));
    }
  }
}
