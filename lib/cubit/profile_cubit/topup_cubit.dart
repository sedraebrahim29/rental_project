import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/profile_cubit/topup_state.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/service/topup_service.dart';


class TopUpCubit extends Cubit<TopUpState> {
  TopUpCubit() : super(TopUpInitial());

  Future<void> topUp(double amount,String lang) async {
    emit(TopUpLoading());
    try {
      final token = await SecureStorage.getToken();

      await TopUpService().topUp(
        amount: amount,
        token: token,
        lang: lang,
      );

      emit(TopUpSuccess());
    } catch (e) {
      emit(TopUpError(e.toString()));
    }
  }
}
