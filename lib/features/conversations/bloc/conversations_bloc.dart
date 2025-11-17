import 'package:bloc/bloc.dart';
import 'package:commet_chat/features/conversations/repository/conversations_repository.dart';
import 'package:equatable/equatable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationsRepository repository;

  int selected = 0;

  ConversationsBloc(this.repository) : super(ConversationsInitial()) {
    on<SelectedTabEvent>(_onTabSelect);
  }

  _onTabSelect(SelectedTabEvent event, emit) {
    selected = event.index;
    emit(SelectedTabState(selectedTab: event.index));
  }
}
