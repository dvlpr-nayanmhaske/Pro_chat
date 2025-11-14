part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class SelectGenderEvent extends RegistrationEvent {
  final String gender;
  const SelectGenderEvent(this.gender);

  @override
  List<Object> get props => [gender];
}

class SelectEmployedInEvent extends RegistrationEvent {
  final String selecteEmploymentIn;
  const SelectEmployedInEvent(this.selecteEmploymentIn);

  @override
  List<Object> get props => [selecteEmploymentIn];
}

class PickImageEvent extends RegistrationEvent {}

class DeleteImageEvent extends RegistrationEvent {
  final int index;

  const DeleteImageEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class SelectProfileImageEvent extends RegistrationEvent {
  final String url;
  const SelectProfileImageEvent(this.url);

  @override
  List<Object> get props => [url];
}


