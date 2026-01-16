abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {
  final int propertyId;
  FavoriteLoading(this.propertyId);
}

class FavoriteUpdated extends FavoriteState {
  final int propertyId;
  final bool isFavorite;

  FavoriteUpdated(this.propertyId, this.isFavorite);
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
