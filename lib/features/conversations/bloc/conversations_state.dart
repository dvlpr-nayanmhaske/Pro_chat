part of 'conversations_bloc.dart';

sealed class ConversationsState extends Equatable {
  const ConversationsState();

  @override
  List<Object> get props => [];
}

final class ConversationsInitial extends ConversationsState {}

class SelectedTabState extends ConversationsState {
  final int selectedTab;

  SelectedTabState({required this.selectedTab});
  @override
  // TODO: implement props
  List<Object> get props => [selectedTab];
}

class GetConversationEventStates extends ConversationsState {}

class GetConversationEventLoadingState extends GetConversationEventStates {}

class GetConversationEventSuccessState extends GetConversationEventStates {
  final DateTime _dateTime = DateTime.now();
  @override
  List<Object> get props => [_dateTime];
}

class GetConversationEventErrorState extends GetConversationEventStates {
  final String error;
  final DateTime _dateTime = DateTime.now();
  GetConversationEventErrorState({required this.error});
  @override
  List<Object> get props => [error, _dateTime];
}
