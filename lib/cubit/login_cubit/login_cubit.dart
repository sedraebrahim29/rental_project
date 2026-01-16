import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/helper/token_storage.dart';
import 'login_state.dart';
import '../../service/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String phone,
    required String password,
    required String lang,}) async {
    emit(LoginLoading());

    try {
     final token =  await LoginService().loginService(
        phone: phone,
        password: password,
       lang: lang,
      );
      await SecureStorage.storeToken(token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

}
