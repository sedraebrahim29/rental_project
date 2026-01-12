import 'package:flutter_bloc/flutter_bloc.dart';

const String baseUrl = 'http://127.0.0.1:8000/api';
//const String bookingUrl = "$baseUrl/bookings";
String token = '';

class UserFullNameCubit extends Cubit<String?> {
  UserFullNameCubit() : super(null);

  void set(String fullName) {
    emit(fullName);
  }

  void clear() {
    emit(null);
  }
}
