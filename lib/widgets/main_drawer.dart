import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/views/homeScreenAndProperties/profile.dart';
import 'package:rent/views/setting_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.primaryContainer,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // AVATAR
                CircleAvatar(
                  radius: 40,
                  backgroundColor: theme.cardColor,
                  child: Icon(
                    Icons.person,
                    size: 45,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 12),

                // USER NAME
                Text(
                  'Ahmad Rahal',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.onPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // MENU ITEMS
          _DrawerItem(
            icon: Icons.person_outline,
            title: t.profile,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Profile()),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.favorite_border,
            title: t.my_favorite,
            onTap: () {},
          ),
          _DrawerItem(
            icon: Icons.archive_outlined,
            title: t.my_booking,
            onTap: () {},
          ),
          _DrawerItem(
            icon: Icons.settings_outlined,
            title: t.settings,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          _DrawerItem(icon: Icons.help_outline, title: t.help, onTap: () {}),
          _DrawerItem(icon: Icons.logout, title: t.logout, onTap: () {}),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: colors.primary.withValues(alpha: 0.15),
        child: Icon(icon, size: 18, color: colors.primary),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colors.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
