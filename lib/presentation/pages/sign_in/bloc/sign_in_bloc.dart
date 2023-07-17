import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_shop_app/domain/usecase/sign_in.dart';
import 'package:online_shop_app/utils/validator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignIn signIn;
  SignInBloc({
    required this.signIn,
  }) : super(SignInInitial()) {
    on<FormSubmitted>((event, emit) async {
      var emailError = InputValidator.validateEmail(event.email);
      var passwordError = InputValidator.validatePassword(event.password);
      if (emailError != null || passwordError != null) {
        emit(SignInError(
            emailErrorMessage: emailError,
            passwordErrorMessage: passwordError));
        return;
      }

      emit(SignInLoading());
      final result = await signIn.execute(event.email, event.password);
      result.fold((error) {
        emit(SignInError(errorMessage: error.message));
      }, (result) {
        emit(SignInSuccess(result));
      });
    });

    on<ChangeEmailEvent>((event, emit) {
      var message = InputValidator.validateEmail(event.email);
      if (message != null) {
        if (state is SignInError) {
          emit((state as SignInError).copyWith(
            emailErrorMessage: message,
          ));
        } else {
          emit(SignInError(errorMessage: message));
        }
      }
    });

    on<ChangePasswordEvent>((event, emit) {
      var message = InputValidator.validateEmail(event.password);
      if (message != null) {
        if (state is SignInError) {
          emit((state as SignInError).copyWith(
            emailErrorMessage: message,
          ));
        } else {
          emit(SignInError(errorMessage: message));
        }
      }
    });
  }
}
