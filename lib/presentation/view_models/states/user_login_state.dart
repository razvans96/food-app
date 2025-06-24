import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_state.freezed.dart';

@freezed
sealed class UserLoginState with _$UserLoginState {
  const factory UserLoginState.initial() = Initial;
  const factory UserLoginState.loading() = Loading;
  const factory UserLoginState.success() = Success;
  const factory UserLoginState.error(String message) = Error;
}
