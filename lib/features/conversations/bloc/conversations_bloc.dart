import 'package:bloc/bloc.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/core/services/logger.dart';

import 'package:commet_chat/core/services/socket_service.dart';
import 'package:commet_chat/features/conversations/models/conversation.dart';
import 'package:commet_chat/features/conversations/repository/conversations_repository.dart';
import 'package:equatable/equatable.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationsRepository repository;

  int selected = 0;

  List<Conversation> conversations = [];

  ConversationsBloc(this.repository) : super(ConversationsInitial()) {
    on<SelectedTabEvent>(_onTabSelect);
    on<GetConversationEvent>(_getConversationEvent);
    on<StartListeningToConversations>(_startListeningToConversations);
    on<StopListeningToConversations>(_stopListeningToConversations);
    on<AddNewConversationEvent>(_addNewConversationEvent);
  }

  _onTabSelect(SelectedTabEvent event, emit) {
    selected = event.index;
    emit(SelectedTabState(selectedTab: event.index));
  }

  _getConversationEvent(GetConversationEvent event, emit) async {
    emit(GetConversationEventLoadingState());
    try {
      conversations = await repository.getConversations();
      emit(GetConversationEventSuccessState());
    } catch (e) {
      emit(GetConversationEventErrorState(error: e.toString()));
    }
  }

  _startListeningToConversations(event, emit) {
    locator<SocketService>().listenEvent("new-conversation", (data) {
      logger.d(data);
      final newConversation = Conversation.fromJson(data);
      add(AddNewConversationEvent(conversation: newConversation));
    });
  }

  _stopListeningToConversations(event, emit) {
    locator<SocketService>().stopListening("new-conversation");
  }

  _addNewConversationEvent(AddNewConversationEvent event, emit) {
    conversations = conversations
        .where((e) => e.id != event.conversation.id)
        .toList();
    conversations.insert(0, event.conversation);

    emit(GetConversationEventSuccessState());
  }
}
