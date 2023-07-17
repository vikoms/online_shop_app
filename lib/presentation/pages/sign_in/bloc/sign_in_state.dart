part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInError extends SignInState {
  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? errorMessage;

  SignInError({
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.errorMessage,
  });

  SignInError copyWith({
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? errorMessage,
  }) =>
      SignInError(
        emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        emailErrorMessage,
        passwordErrorMessage,
        errorMessage,
      ];
}

class SignInSuccess extends SignInState {
  final UserCredential user;

  SignInSuccess(this.user);

  @override
  List<Object> get props => [user];
}
