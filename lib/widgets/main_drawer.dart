import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/core/constant.dart';
import 'package:rent/cubit/user_cubit.dart';
import 'package:rent/cubit/user_state.dart';

import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/profile_model.dart';
import 'package:rent/models/property_model.dart';

import 'package:rent/views/homeScreenAndProperties/profile.dart';

import 'package:rent/views/my_booking.dart';
import 'package:rent/views/setting_screen.dart';

import '../cubit/property_cubit.dart';
import '../cubit/property_state.dart';
import '../data/colors.dart';
import '../views/my_favorite.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; //للترجمة
    return Drawer(
      backgroundColor: MyColor.offWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColor.deepBlue, MyColor.skyBlue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return Column(
                    children: [
                      // AVATAR
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(state.user.image),
                      ),
                      const SizedBox(height: 12),

                      // USER NAME

                      // Read the userName variable directly from the Cubi
                      Text(
                        state.user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColor.deepBlue,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
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
                MaterialPageRoute(builder: (_) => Profile()),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.favorite_border,

            title: 'My favorites',
            onTap: () {
              // Close the drawer first
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyFavoriteScreen()),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.archive_outlined,
            title: t.my_booking,
            onTap: () {
              // Close the drawer first
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyBooking()),
              );
            },
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
          _DrawerItem(icon: Icons.help_outline, title: 'Help', onTap: () {}),
          _DrawerItem(
            icon: Icons.logout,
            title: 'Log out',
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }
}

// HELPERS
void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        "Log Out",
        style: TextStyle(color: MyColor.deepBlue, fontWeight: FontWeight.bold),
      ),
      content: const Text("Are you sure you want to log out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx), // Close dialog
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            context.read<PropertyCubit>().logout(context);
          },
          child: const Text("Log Out", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: MyColor.skyBlue.withValues(alpha: 0.3),
        child: Icon(icon, size: 18, color: MyColor.deepBlue),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: MyColor.deepBlue),
      ),
    );
  }
}
