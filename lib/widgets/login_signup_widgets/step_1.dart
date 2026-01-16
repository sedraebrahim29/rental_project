import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/login_signup_widgets/textfieldwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';

class Step1 extends StatelessWidget {
  const Step1({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.birthDateController,
    required this.onNext,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController birthDateController;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    final firstName = TextFieldModel(
      text: t.your_first_name,
      hintText: t.enter_first_name,
      controller: firstNameController,
    );

    final lastName = TextFieldModel(
      text: t.your_last_name,
      hintText: t.enter_last_name,
      controller: lastNameController,
    );

    return Column(
      children: [
        Textfieldwidget(firstName),
        const SizedBox(height: 25),
        Textfieldwidget(lastName),
        const SizedBox(height: 25),

        // Birthday label
         Padding(
          padding: EdgeInsets.only(right: 200, bottom: 5),
          child: Text(
            t.your_birthday,
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'DM Serif Display',
              color: Colors.white,
            ),
          ),
        ),

        // Birthday picker
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            controller: birthDateController,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: t.date_hint,
              hintStyle: const TextStyle(
                fontFamily: 'DM Serif Display',
                fontSize: 17,
                color: Color(0xff5B7CA9),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onTap: () async {
              final now = DateTime.now();
              final minAgeDate = DateTime(
                  now.year - 15,
                  12,
                  31
              );

              final date = await showDatePicker(
                context: context,
                initialDate: DateTime(minAgeDate.year), // 👈 بداية سنة 2011
                firstDate: DateTime(1936),
                lastDate: minAgeDate,
              );

              if (date != null) {
                birthDateController.text =
                '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              }
            },
          ),
        ),

        const SizedBox(height: 155),

        // NEXT BUTTON
        Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
            color: const Color(0xff011963),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // trigger cubit (Step 1 data)
                context.read<SignupCubit>().setStep1Data(
                  first: firstNameController.text,
                  last: lastNameController.text,
                  birth: birthDateController.text,
                );

                onNext();
              },
              child:  Text(
                t.next,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'DM Serif Display',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
