import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/cubit/language_cubit/language_state.dart';
import 'package:rent/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff353F7A),
        title: Text(t.settings,
        style: TextStyle(
          color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Language",
                  style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold,
                  color: Color(0xff0C0E4C)),
                ),
                const SizedBox(height: 15),

                DropdownButton<String>(
                  value: state.languageCode,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English',
                        style: TextStyle( color: Color(0xff0C0E4C)),
                        ),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text('العربية',
                        style: TextStyle( color: Color(0xff0C0E4C)),
                        ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LanguageCubit>().changeLanguage(value);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
