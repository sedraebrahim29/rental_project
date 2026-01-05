part of 'properties_cubit.dart';

enum State { init, loading, success, error }

class PropertiesState {
  final State state;
   String error = '';
  final List<PropertyModel> properties;
  final PropertyModel property;

  // New Lists for Bookings
  final List<PropertiesBookingModel> pendingBookings;
  final List<PropertiesBookingModel> currentBookings;
  final List<PropertiesBookingModel> updateRequests;

  PropertiesState({
    required this.state,
    this.error = '',
    required this.properties,
    required this.property,
    this.pendingBookings = const [],
    this.currentBookings = const [],
    this.updateRequests = const [],
  });

  factory PropertiesState.init() {
    return PropertiesState(
      state: State.init,
      properties: const [],
      property: PropertyModel.init(),
    );
  }
  factory PropertiesState.loading() {
    return PropertiesState(
      state: State.loading,
      properties: const [],
      property: PropertyModel.init(),
    );
  }
  factory PropertiesState.success(List<PropertyModel> properties) {
    return PropertiesState(
      state: State.success,
      properties: properties,
      property: PropertyModel.init(),
    );
  }

  // New Factory for Bookings Success
  factory PropertiesState.bookingsSuccess({
    required List<PropertiesBookingModel> pending,
    required List<PropertiesBookingModel> current,
    required List<PropertiesBookingModel> updates,
    required List<PropertyModel> existingProperties, // Keep properties loaded
  }) {
    return PropertiesState(
      state: State.success,
      properties: existingProperties,
      property: PropertyModel.init(),
      pendingBookings: pending,
      currentBookings: current,
      updateRequests: updates,
    );
  }

  factory PropertiesState.error(String error) {
    return PropertiesState(
      state: State.error,
      error: error,
      properties: const [],
      property: PropertyModel.init(),
    );
  }

}
