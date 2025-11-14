part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitial extends RegistrationState {}

class SelectGenderState extends RegistrationState {
  final String gender;
  const SelectGenderState({required this.gender});

  @override
  List<Object> get props => [gender];
}

class SelecteEmploymentInState extends RegistrationState {
  final String selecteEmploymentIn;
  const SelecteEmploymentInState({required this.selecteEmploymentIn});

  @override
  List<Object> get props => [selecteEmploymentIn];
}

class PickImageStates extends RegistrationState {}

class PickImageLoadingState extends PickImageStates {}

class PickImageSuccessState extends PickImageStates {
  final List<String> image;
  final DateTime dateTime = DateTime.now();

  PickImageSuccessState({required this.image});

  @override
  List<Object> get props => [image, dateTime];
}

class PickImageErrorState extends PickImageStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  PickImageErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}


class DeleteImageState extends PickImageStates{}

class ProfileImageSelectedState extends RegistrationState {
  final String url;
  const ProfileImageSelectedState(this.url);

  @override
  List<Object> get props => [url];
}

