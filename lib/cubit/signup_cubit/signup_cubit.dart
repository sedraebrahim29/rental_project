import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';
import '../../service/signup_service.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String birthday,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(SignupLoading());

    try {
      await SignupService().signup(
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }

}
