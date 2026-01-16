import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/service/favorite_sevice.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteService service;

  FavoriteCubit(this.service) : super(FavoriteInitial());

  Future<void> toggleFavorite({required int propertyId}) async {
    emit(FavoriteLoading(propertyId));

    try {
      final isFavorite = await service.toggleFavorite(
        propertyId: propertyId,
        token: SecureStorage.getToken().toString(),
      );

      emit(FavoriteUpdated(propertyId, isFavorite));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
