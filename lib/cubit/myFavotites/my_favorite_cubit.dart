import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repos/my_favorite_repo.dart';

import 'my_favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState.init());

  final FavoriteRepo favoriteRepo = FavoriteRepo();

  Future<void> getFavorites() async {
    emit(FavoriteState.loading());
    try {
      var favorites = await favoriteRepo.getFavorites();
      emit(FavoriteState.success(favorites));
    } catch (e) {
      emit(FavoriteState.error(e.toString()));
    }
  }
}
