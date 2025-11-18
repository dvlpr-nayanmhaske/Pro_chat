part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetMessagesEvent extends ChatEvent {
  final String conversationId;

  const GetMessagesEvent({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}

class GetUserDetailsEvent extends ChatEvent {
  final String conversationId;

  GetUserDetailsEvent({required this.conversationId});

  @override
  // TODO: implement props
  List<Object> get props => [conversationId];
}

class SendMessageEvent extends ChatEvent {
  final String message;

  const SendMessageEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class StartListenToNewMessages extends ChatEvent {
  final String conversationId;

  const StartListenToNewMessages({required this.conversationId});

  @override
  List<Object> get props => [conversationId];
}

class StopListenToNewMessages extends ChatEvent {}

class AddNewMessageEvent extends ChatEvent {
  final Message message;

  const AddNewMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateMessageEvent extends ChatEvent {}
