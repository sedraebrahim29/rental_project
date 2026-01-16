import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system); // الوضع الافتراضي حسب الجهاز

  void setLight() => emit(ThemeMode.light);
  void setDark() => emit(ThemeMode.dark);
  void setSystem() => emit(ThemeMode.system);

  void toggle(bool isDark) {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
