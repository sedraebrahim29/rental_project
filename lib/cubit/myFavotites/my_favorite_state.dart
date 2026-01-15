



import '../../models/property_model.dart';

enum FavoriteStatus { init, loading, success, error }

class FavoriteState {
  final FavoriteStatus state;
  final String error;
  final List<PropertyModel> favorites;

  FavoriteState({
    required this.state,
    this.error = '',
    required this.favorites,
  });

  factory FavoriteState.init() {
    return FavoriteState(
      state: FavoriteStatus.init,
      favorites: const [],
    );
  }

  factory FavoriteState.loading() {
    return FavoriteState(
      state: FavoriteStatus.loading,
      favorites: const [],
    );
  }

  factory FavoriteState.success(List<PropertyModel> favorites) {
    return FavoriteState(
      state: FavoriteStatus.success,
      favorites: favorites,
    );
  }

  factory FavoriteState.error(String error) {
    return FavoriteState(
      state: FavoriteStatus.error,
      error: error,
      favorites: const [],
    );
  }
}