import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/views/homeScreenAndProperties/my_properties.dart';
import '../views/homeScreenAndProperties/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // ===== OVERLAY فوق صورة الخلفية =====
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withAlpha(0)
                : Colors.white.withAlpha(0),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ================= TOP BAR =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: theme.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),

                    // ================= SEARCH BAR =================
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SearchScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 36,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [],
                        ),
                        child: Text(
                          t.search,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: theme.colorScheme.onSurface,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ================= CATEGORY BUTTONS =================
                Row(
                  children: [
                    _CategoryButtons(
                      title: t.my_properties,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyPropertiesScreen(),
                          ),
                        );
                      },
                      backgroundColor: theme.colorScheme.secondary,
                      textColor: theme.colorScheme.onSurface,
                    ),
                    const SizedBox(width: 16),
                    _CategoryButtons(
                      title: t.rent,
                      onTap: () {},
                      backgroundColor: theme.colorScheme.secondary,
                      textColor: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(width: 16),
                    _CategoryButtons(
                      title: t.messages,
                      onTap: () {},
                      backgroundColor: theme.colorScheme.secondary,
                      textColor: theme.colorScheme.onSurface,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryButtons extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const _CategoryButtons({
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
