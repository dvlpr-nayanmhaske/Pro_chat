import 'package:commet_chat/features/chat/pages/chat_screen.dart';
import 'package:commet_chat/features/conversations/pages/conversations_screen.dart';
import 'package:go_router/go_router.dart';

enum Routes { conversationScreen, chatScreen }

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: Routes.conversationScreen.name,
      builder: (context, state) => ConversationsScreen(),
    ),
    GoRoute(
      path: "/chat",
      name: Routes.chatScreen.name,
      builder: (context, state) => ChatScreen(),
    ),
  ],
);
