import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/widgets/profile_widget/profile_bottom_sheet.dart';
import 'package:rent/cubit/profile_cubit/profile_cubit.dart';
import 'package:rent/cubit/profile_cubit/profile_state.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _loadProfile() {
    final lang = context.read<LanguageCubit>().state.languageCode;
    context.read<ProfileCubit>().getProfile(lang);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is ProfileLoaded) {
            final prof = state.profile;

            return Stack(
              children: [
                // Background image
                const Positioned.fill(
                  child: Image(
                    image: AssetImage('assets/android_compact_1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay
                Positioned.fill(
                  child: Container(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.65)
                        : Colors.black.withValues(alpha: 0.25),
                  ),
                ),

                // Content
                Column(
                  children: [
                    const SizedBox(height: 100),

                    CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(prof.image),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      '${prof.firstName} ${prof.lastName}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 210,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.cardColor.withValues(alpha: 0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          t.edit_profile,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.only(right: 115),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoText(context, "${t.phone_number}: ${prof.phone}"),
                          const SizedBox(height: 25),
                          _infoText(context, "${t.birth_date}: ${prof.birthDate}"),
                          const SizedBox(height: 25),
                          _infoText(context, "${t.properties}: ${prof.propertiesCount}"),
                          const SizedBox(height: 25),
                          _infoText(context, "${t.balance}: ${prof.balance}"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    SizedBox(
                      width: 270,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.cardColor.withValues(alpha: 0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(80),
                              ),
                            ),
                            builder: (_) => const ProfileBottomSheet(),
                          );
                        },
                        child: Text(
                          t.top_up_balance,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _infoText(BuildContext context, String text) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.bodyLarge?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
