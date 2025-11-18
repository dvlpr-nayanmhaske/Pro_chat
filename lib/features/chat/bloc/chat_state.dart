part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class GetMessagesEventStates extends ChatState {}

class GetMessagesEventLoadingState extends GetMessagesEventStates {}

class GetMessagesEventSuccessState extends GetMessagesEventStates {
  final DateTime _dateTime = DateTime.now();

  @override
  List<Object> get props => [_dateTime];
}

class GetMessagesEventErrorState extends GetMessagesEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  GetMessagesEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}

class GetUserDetailsEventStates extends ChatState {}

class GetUserDetailsEventLoadingState extends GetUserDetailsEventStates {}

class GetUserDetailsEventSuccessState extends GetUserDetailsEventStates {}

class GetUserDetailsEventErrorState extends GetUserDetailsEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  GetUserDetailsEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}

class SendMessageEventStates extends ChatState {}

class SendMessageEventLoadingState extends SendMessageEventStates {}

class SendMessageEventSuccessState extends SendMessageEventStates {}

class SendMessageEventErrorState extends SendMessageEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  SendMessageEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}
