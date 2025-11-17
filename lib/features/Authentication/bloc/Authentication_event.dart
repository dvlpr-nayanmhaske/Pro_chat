part of 'Authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppHandelEvent extends AuthenticationEvent {}

class SendOtpEvent extends AuthenticationEvent {
  final String phoneNo;

  const SendOtpEvent({required this.phoneNo});

  @override
  List<Object> get props => [phoneNo];
}

class LogOutEvent extends AuthenticationEvent {}

class ValidateOtpEvent extends AuthenticationEvent {
  final String otp;

  const ValidateOtpEvent({required this.otp});

  @override
  // TODO: implement props
  List<Object> get props => [otp];
}
