import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_register_state.freezed.dart';

@freezed
sealed class UserRegisterState with _$UserRegisterState {
  const factory UserRegisterState.initial() = Initial;
  const factory UserRegisterState.loading() = Loading;
  const factory UserRegisterState.success() = Success;
  const factory UserRegisterState.error(String message) = Error;
}
