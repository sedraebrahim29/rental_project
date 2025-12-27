import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import '../../service/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String phone, required String password}) async {
    emit(LoginLoading());

    try {
      await LoginService().loginService(
        phone: phone,
        password: password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

}
