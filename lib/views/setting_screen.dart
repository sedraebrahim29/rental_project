import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/cubit/language_cubit/language_state.dart';
import 'package:rent/cubit/theme_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          t.settings,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.language,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                DropdownButton<String>(
                  value: state.languageCode,
                  isExpanded: true,
                  dropdownColor: theme.cardColor,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'English',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text(
                        'العربية',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LanguageCubit>().changeLanguage(value);
                    }
                  },
                ),
                const SizedBox(height: 35),

                Text(
                  t.theme_mode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, mode) {
                    final isDark = mode == ThemeMode.dark;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isDark ? t.dark_mode : t.light_mode,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Switch(
                          value: isDark,
                          onChanged: (value) {
                            context.read<ThemeCubit>().toggle(value);
                          },
                          activeColor: theme.colorScheme.primary,
                        ),
                      ],
                    );
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
