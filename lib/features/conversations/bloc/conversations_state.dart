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
