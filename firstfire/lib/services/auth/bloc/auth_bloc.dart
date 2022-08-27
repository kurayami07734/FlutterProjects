import 'package:firstfire/services/auth/auth_provider.dart';
import 'package:firstfire/services/auth/bloc/auth_event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firstfire/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(
          isLoading: true,
        )) {
    on<AuthEventInitialize>(
      (event, emit) async {
        await provider.initialize();
        final user = provider.currentUser;
        if (user == null) {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
        } else if (!user.isEmailVerified) {
          emit(const AuthStateNeedsEmailVerification(false));
        } else {
          emit(AuthStateLoggedIn(
            user: user,
            isLoading: false,
          ));
        }
      },
    );
    on<AuthEventLogin>(
      ((event, emit) async {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
        ));
        final email = event.email;
        final password = event.password;
        try {
          final user = await provider.login(
            email: email,
            password: password,
          );
          if (!user.isEmailVerified) {
            emit(const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ));
            emit(const AuthStateNeedsEmailVerification(false));
          } else {
            emit(const AuthStateLoggedOut(
              exception: null,
              isLoading: true,
              loadingText: "Please wait while we log you in",
            ));
            emit(AuthStateLoggedIn(
              user: user,
              isLoading: false,
            ));
          }
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
              isLoading: false,
            ),
          );
        }
      }),
    );
    on<AuthEventLogout>(
      ((event, emit) async {
        try {
          await provider.logout();
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
        } on Exception catch (e) {
          emit(AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ));
        }
      }),
    );
    on<AuthEventSendEmailVerification>(
      ((event, emit) async {
        await provider.sendEmailVerification();
        emit(state);
      }),
    );
    on<AuthEventShouldRegister>(
      (event, emit) {
        emit(const AuthStateRegistering(
          exception: null,
          isLoading: false,
        ));
      },
    );
    on<AuthEventRegister>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsEmailVerification(false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(
          exception: e,
          isLoading: false,
        ));
      }
    });
  }
}
