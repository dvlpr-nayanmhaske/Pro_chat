import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'Authentication_event.dart';
part 'Authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}