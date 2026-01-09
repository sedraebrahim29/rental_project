abstract class EditPropertyState {}

class EditPropertyInitial extends EditPropertyState {}

class EditPropertyLoading extends EditPropertyState {}

class EditPropertyLoaded extends EditPropertyState {}

class EditPropertyUpdating extends EditPropertyState {}

class EditPropertySuccess extends EditPropertyState {}

class EditPropertyError extends EditPropertyState {
  final String message;
  EditPropertyError(this.message);
}