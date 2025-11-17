part of 'Authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

class SendOtpEventStates extends AuthenticationState {}

class SendOtpEventLoadingState extends SendOtpEventStates {}

class SendOtpEventSuccessState extends SendOtpEventStates {}

class SendOtpEventErrorState extends SendOtpEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  SendOtpEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}

class ValidateOtpEventStates extends AuthenticationState {}

class ValidateOtpEventLoadingState extends ValidateOtpEventStates {}

class ValidateOtpEventSuccessState extends ValidateOtpEventStates {}

class ValidateOtpEventErrorState extends ValidateOtpEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  ValidateOtpEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}
