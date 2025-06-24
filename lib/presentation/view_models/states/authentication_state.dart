import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.checking() = Checking;
  const factory AuthenticationState.guest() = Guest;
  const factory AuthenticationState.authenticated(User user) = Authenticated;
  const factory AuthenticationState.profileIncomplete(User user) =
      ProfileIncomplete;
}

extension AuthenticationStateRouting on AuthenticationState {
  String get initialRoute {
    return switch (this) {
      Checking() => '/query',
      Guest() => '/query',
      Authenticated() => '/query',
      ProfileIncomplete() => '/register',
    };
  }
}
