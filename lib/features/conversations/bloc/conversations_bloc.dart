import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  int selected = 0;

  ConversationsBloc() : super(ConversationsInitial()) {
    on<SelectedTabEvent>(_onTabSelect);
  }

  _onTabSelect(SelectedTabEvent event, emit) {
    selected = event.index;
    emit(SelectedTabState(selectedTab: event.index));
  }
}
