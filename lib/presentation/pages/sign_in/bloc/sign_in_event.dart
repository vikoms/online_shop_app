part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class ChangeEmailEvent extends SignInEvent {
  final String email;
  ChangeEmailEvent(this.email);

  @override
  List<Object> get props => [
        email,
      ];
}

class ChangePasswordEvent extends SignInEvent {
  final String password;
  ChangePasswordEvent(this.password);

  @override
  List<Object> get props => [
        password,
      ];
}

class FormSubmitted extends SignInEvent {
  final String email;
  final String password;
  FormSubmitted(this.email, this.password);

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
