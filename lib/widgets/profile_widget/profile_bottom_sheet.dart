import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/cubit/profile_cubit/topup_cubit.dart';
import 'package:rent/cubit/profile_cubit/topup_state.dart';

import 'package:rent/data/colors.dart';
import 'package:rent/l10n/app_localizations.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // provide + integrate
    return BlocProvider(
      create: (context) => TopUpCubit(),
      child: Builder(
        builder: (context) {
          return BlocListener<TopUpCubit, TopUpState>(
            listener: (context, state) {
              if (state is TopUpSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(t.balance_success)),
                );
              }

              if (state is TopUpError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                     Text(
                      t.enter_amount,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: MyColor.deepBlue,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      height: 60,
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: MyColor.deepBlue),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: MyColor.deepBlue,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Expanded(
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              cursorColor: MyColor.deepBlue,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '0',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.deepBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        final value = double.tryParse(amountController.text);

                        if (value == null || value <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(t.enter_valid_amount)),
                          );
                          return;
                        }
                        final lang = context.read<LanguageCubit>().state.languageCode;
                        //trigger
                        context.read<TopUpCubit>().topUp(value,lang);
                      },
                      child:  Text(
                        t.submit,
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
