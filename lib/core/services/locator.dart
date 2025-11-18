import 'package:commet_chat/core/services/api_client.dart';
import 'package:commet_chat/core/services/socket_service.dart';
import 'package:commet_chat/features/Authentication/bloc/Authentication_bloc.dart';
import 'package:commet_chat/features/Authentication/repository/Authentication_repository.dart';
import 'package:commet_chat/features/conversations/bloc/conversations_bloc.dart';
import 'package:commet_chat/features/conversations/repository/conversations_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  // AUTHENTICATON BLOC
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator.registerLazySingleton<SocketService>(() => SocketService());

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepository(locator<ApiClient>()),
  );

  locator.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(locator<AuthenticationRepository>()),
  );

  // LOCATOR BLOC

  locator.registerLazySingleton<ConversationsRepository>(
    () => ConversationsRepository(apiClient: locator<ApiClient>()),
  );

  locator.registerLazySingleton<ConversationsBloc>(
    () => ConversationsBloc(locator<ConversationsRepository>()),
  );
}
