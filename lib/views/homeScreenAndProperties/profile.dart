import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/profile_model.dart';
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
    context.read<ProfileCubit>().getProfile(lang);//trigger
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    }); // trigger
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //integrate cubit
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

            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/android_compact_1.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),

                  CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(prof.image),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    '${prof.firstName} ${prof.lastName}',
                    style: const TextStyle(
                      color: MyColor.deepBlue,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: SizedBox(
                      width: 210,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          t.edit_profile,
                          style: TextStyle(
                            fontSize: 17,
                            color: MyColor.deepBlue,
                          ),
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
                        Text(
                    "${t.phone_number}: ${prof.phone}",
                    style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColor.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "${t.birth_date} : ${prof.birthDate}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColor.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "${t.properties} : ${prof.propertiesCount}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColor.deepBlue,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "${t.balance} : ${prof.balance}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: MyColor.deepBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  Center(
                    child: SizedBox(
                      width: 270,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
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
                        child:  Text(
                          t.top_up_balance,
                          style: TextStyle(
                            fontSize: 17,
                            color: MyColor.deepBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

// FilterInfoRow(label: 'Phone number', field: Input()),
// SizedBox(height: 25),
// FilterInfoRow(label: 'Birth date', field: Input()),
// SizedBox(height: 25),
// FilterInfoRow(label: 'Properties', field: Input()),
// SizedBox(height: 25),
// FilterInfoRow(label: 'Balance', field: Input()),
