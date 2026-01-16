import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';
import '../../service/signup_service.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  String? firstName;
  String? lastName;
  String? birthday;
  String? phone;
  String? password;
  String? passwordConfirmation;


  void setStep1Data({
    required String first,
    required String last,
    required String birth,
  }) {
    firstName = first;
    lastName = last;
    birthday = birth;
  }

  void setStep2Data({
    required String phoneNumber,
    required String pass,
    required String confirmPass,
  }) {
    phone = phoneNumber;
    password = pass;
    passwordConfirmation = confirmPass;
  }

  Future<void> signup({
    required File image,
    required File idImage,
    required String lang,
  }) async {

    if (firstName == null ||
        lastName == null ||
        birthday == null ||
        phone == null ||
        password == null ||
        passwordConfirmation == null) {
      emit(SignupError('Please complete all steps'));
      return;
    }
    emit(SignupLoading());
    try {
      await SignupService().signup(
        firstName: firstName!,
        lastName: lastName!,
        birthDate: birthday!,
        phone: phone!,
        password: password!,
        passwordConfirmation: passwordConfirmation!,
        image: image,
        idImage: idImage,
        lang: lang,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupError(e.toString()));
    }
  }
}

