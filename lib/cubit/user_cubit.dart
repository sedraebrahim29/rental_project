import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/user_state.dart';
import 'package:rent/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void login({
    required String name,
    required String image,
    required String token,
  }) {
    emit(AuthAuthenticated(UserModel(name: name, image: image, token: token)));
  }

  void logout() {
    emit(AuthLoggedOut());
  }
}
