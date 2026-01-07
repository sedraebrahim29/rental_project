import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/helper/token_storage.dart';
import 'details_state.dart';
import '../../service/details_service.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getDetails(int id) async {
    emit(DetailsLoading());
    try {
      final token = await SecureStorage.getToken();

      final property = await DetailsService().getDetails(id: id, token: token);
      emit(DetailsSuccess(property));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}
