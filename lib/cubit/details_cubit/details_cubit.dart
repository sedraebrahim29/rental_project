import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/helper/token_storage.dart';
import 'details_state.dart';
import '../../service/details_service.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getDetails(int id) async {
    emit(DetailsLoading());
    try {

      final token = await TokenStorage.getToken();

      if (token == null) {
        throw Exception('No token found');
      }

      final property = await DetailsService().getDetails(
          id: id,
        token: token,);
      emit(DetailsSuccess(property));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}
