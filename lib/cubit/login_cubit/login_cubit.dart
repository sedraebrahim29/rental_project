import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/user_cubit.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'login_state.dart';
import '../../service/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthCubit authCubit;
  LoginCubit(this.authCubit) : super(LoginInitial());

  Future<void> login({required String phone, required String password}) async {
    emit(LoginLoading());

    try {
      final result = await LoginService().loginService(
        phone: phone,
        password: password,
      );

      final token = result.token;
      await secureStorage.write(key: 'token', value: token);
      authCubit.login(name: result.name, image: result.image, token: token);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
