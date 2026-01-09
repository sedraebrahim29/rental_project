abstract class TopUpState {}

class TopUpInitial extends TopUpState {}

class TopUpLoading extends TopUpState {}

class TopUpSuccess extends TopUpState {}

class TopUpError extends TopUpState {
  final String message;
  TopUpError(this.message);
}
