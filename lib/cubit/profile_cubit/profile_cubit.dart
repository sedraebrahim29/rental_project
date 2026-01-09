import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/service/profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final token = await SecureStorage.getToken();

      final profile = await ProfileService().getProfile(token: token);

      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
