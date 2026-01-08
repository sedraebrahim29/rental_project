import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repos/logout_and_fullname_repo.dart';
import '../core/repos/property_repo.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial());

  final PropertyRepo propertyRepo = PropertyRepo();
  final LogoutRepo logoutRepo = LogoutRepo();

  /// Fetch All Properties for Home Screen
  Future<void> getAllProperties() async {
    emit(PropertyLoading());
    try {
      // Fetch data from Repo
      final properties = await propertyRepo.getHomeProperties();

      // Emit the Loaded state with the list
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  /// Logout Function
  Future<void> logout(BuildContext context) async {
    // We don't emit a state here to avoid breaking the Home Screen UI
    // while the dialog is open. We just execute the logic.
    await logoutRepo.logout();

    // Navigate to Login Screen and remove all previous routes
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login', // Make sure this matches your route name in main.dart
            (route) => false,
      );
    }
  }
}