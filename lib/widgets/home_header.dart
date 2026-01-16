import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/views/homeScreenAndProperties/my_properties.dart';
import '../views/homeScreenAndProperties/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; // للترجمة
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: colors.onSurface),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),

                    // SEARCH BAR
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
                        height: 35,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          t.search,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: colors.onSurface,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    // MY PROPERTIES
                    _CategoryButtons(
                      title: t.my_properties,
                      backgroundColor: theme.cardColor,
                      textColor: colors.primary,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyPropertiesScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),

                    // RENT
                    _CategoryButtons(
                      title: t.rent,
                      backgroundColor: colors.primary.withValues(alpha: 0.15),
                      textColor: colors.primary,
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),

                    // MESSAGES
                    _CategoryButtons(
                      title: t.messages,
                      backgroundColor: theme.cardColor,
                      textColor: colors.primary,
                      onTap: () {},
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
