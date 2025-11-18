import 'package:bloc/bloc.dart';
import 'package:commet_chat/core/services/locator.dart';
import 'package:commet_chat/core/services/logger.dart';
import 'package:commet_chat/core/services/socket_service.dart';
import 'package:commet_chat/features/chat/models/message.dart';
import 'package:commet_chat/features/chat/models/user_details.dart';
import 'package:commet_chat/features/chat/repository/chat_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  List<Message> messages = [];
  UserDetails? user;

  String conversationId = "";

  ChatBloc(this.repository) : super(ChatInitial()) {
    on<GetMessagesEvent>(_getMessagesEvent);
    on<GetUserDetailsEvent>(_getUserDetailsEvent);
    on<SendMessageEvent>(_sendMessageEvent);
    on<StartListenToNewMessages>(_startListenToNewMessages);
    on<StopListenToNewMessages>(_stopListenToNewMessages);
    on<AddNewMessageEvent>(_addNewMessageEvent);
    on<UpdateMessageEvent>((event, emit) {
      emit(GetMessagesEventSuccessState());
    });
  }

  _getMessagesEvent(GetMessagesEvent event, emit) async {
    conversationId = event.conversationId;
    emit(GetMessagesEventLoadingState());
    try {
      repository.markAsSeen(conversationId);
      messages = await repository.getMessages(event.conversationId);
      emit(GetMessagesEventSuccessState());
    } catch (e) {
      emit(GetMessagesEventErrorState(error: e.toString()));
    }
  }

  _getUserDetailsEvent(GetUserDetailsEvent event, emit) async {
    emit(GetUserDetailsEventLoadingState());
    try {
      user = await repository.getUserDetails(event.conversationId);
      emit(GetUserDetailsEventSuccessState());
    } catch (e) {
      emit(GetUserDetailsEventErrorState(error: e.toString()));
    }
  }

  _sendMessageEvent(SendMessageEvent event, emit) async {
    emit(SendMessageEventLoadingState());
    try {
      await repository.sendMessage(
        conversationId: conversationId,
        text: event.message,
        receiverId: user?.id ?? "NA",
      );
      emit(SendMessageEventSuccessState());
    } catch (e) {
      emit(SendMessageEventErrorState(error: e.toString()));
    }
  }

  _startListenToNewMessages(StartListenToNewMessages event, emit) {
    locator<SocketService>().listenEvent(
      "conversation_${event.conversationId}",
      (data) {
        final Message message = Message.fromJson(data);
        add(AddNewMessageEvent(message));
      },
    );
    locator<SocketService>().listenEvent(
      "conversation_updates_${event.conversationId}",
      (data) {
        final List seenMessages = data['messages'];

        for (Message m in messages) {
          if (seenMessages.contains(m.id)) {
            m.status = "seen";
          }
        }

        add(UpdateMessageEvent());
      },
    );
  }

  _stopListenToNewMessages(StopListenToNewMessages event, emit) {
    locator<SocketService>().stopListening("conversation_$conversationId");
  }

  _addNewMessageEvent(AddNewMessageEvent event, emit) {
    messages.insert(0, event.message);
    emit(GetMessagesEventSuccessState());
  }
}
