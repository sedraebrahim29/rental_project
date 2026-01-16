import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const _storage = FlutterSecureStorage();
  static const _key = 'app_language';

  LanguageCubit() : super(const LanguageState(Locale('en'))) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final saved = await _storage.read(key: _key);
    if (saved != null && saved.isNotEmpty) {
      emit(LanguageState(Locale(saved)));
    }
  }

  Future<void> changeLanguage(String code) async {
    await _storage.write(key: _key, value: code);
    emit(LanguageState(Locale(code)));
  }
}
