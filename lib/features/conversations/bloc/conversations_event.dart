part of 'conversations_bloc.dart';

sealed class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object> get props => [];
}

class SelectedTabEvent extends ConversationsEvent {
  int index;

  SelectedTabEvent({required this.index});

  @override
  List<Object> get props => [index];
}

class GetConversationEvent extends ConversationsEvent {}

class StartListeningToConversations extends ConversationsEvent {}

class StopListeningToConversations extends ConversationsEvent {}

class AddNewConversationEvent extends ConversationsEvent {
  final Conversation conversation;

  AddNewConversationEvent({required this.conversation});

  @override
  // TODO: implement props
  List<Object> get props => [conversation];
}
