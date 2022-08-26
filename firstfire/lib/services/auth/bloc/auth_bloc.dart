import 'package:firstfire/services/auth/auth_provider.dart';
import 'package:firstfire/services/auth/bloc/auth_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firstfire/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    on<AuthEventInitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(null));
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsEmailVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      },
    );
    on<AuthEventLogin>(
      ((event, emit) async {
        emit(const AuthStateUninitialized());
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.login(
            email: email,
            password: password,
          );
          emit(AuthStateLoggedIn(user));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(e));
        }
      }),
    );
    on<AuthEventLogout>(
      ((event, emit) async {
        try {
          await provider.logout();
          emit(const AuthStateLoggedOut(null));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(e));
        }
      }),
    );
    on<AuthEventSendEmailVerification>(
      ((event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      }),
    );
    on<AuthEventRegister>();
  }
}
