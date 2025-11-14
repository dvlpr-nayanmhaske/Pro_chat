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
