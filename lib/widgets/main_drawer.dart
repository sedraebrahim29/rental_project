import 'package:flutter/material.dart';
import 'package:rent/views/my_booking.dart';

import '../data/colors.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                // AVATAR
                CircleAvatar(
                  radius: 40,
                  backgroundColor: MyColor.offWhite,
                  child: Icon(Icons.person, size: 45, color: MyColor.deepBlue),
                ),
                const SizedBox(height: 12),
                // USER NAME
                const Text(
                  'Ahmad Rahal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyColor.deepBlue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // MENU ITEMS
          _DrawerItem(
            icon: Icons.person_outline,
            title: 'My profile',
            onTap: () {},
          ),
          _DrawerItem(
            icon: Icons.favorite_border,
            title: 'My favorite',
            onTap: () {},
          ),
          _DrawerItem(
            icon: Icons.apartment_sharp,
            title: 'My booking',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MyBooking()),
              );
            },
          ),
          _DrawerItem(
            icon: Icons.settings_outlined,
            title: 'Setting',
            onTap: () {},
          ),
          _DrawerItem(icon: Icons.help_outline, title: 'Help', onTap: () {}),
          _DrawerItem(icon: Icons.logout, title: 'Log out', onTap: () {}),
        ],
      ),
    );
  }
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
