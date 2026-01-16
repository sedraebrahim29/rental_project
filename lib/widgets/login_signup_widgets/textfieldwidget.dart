import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';

class Textfieldwidget extends StatefulWidget {
  const Textfieldwidget(this.tx, {super.key});

  final TextFieldModel tx;

  @override
  State<Textfieldwidget> createState() => _TextfieldwidgetState();
}

class _TextfieldwidgetState extends State<Textfieldwidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 45, bottom: 5),
          child: Text(
            widget.tx.text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: 'DM Serif Display',
              fontSize: 17,
              color: colors.onSurface,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            controller: widget.tx.controller,
            obscureText: widget.tx.isPassword ? obscure : false,
            cursorColor: colors.primary,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: 'DM Serif Display',
              fontSize: 17,
              color: colors.onSurface,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.cardColor,
              hintText: widget.tx.hintText,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                fontFamily: 'DM Serif Display',
                fontSize: 17,
                color: colors.onSurface.withValues(alpha: 0.5),
              ),

              //////////////////////////////////////////
              suffixIcon: widget.tx.isPassword
                  ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: colors.primary,
                ),
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
              )
                  : null,
              ///////////////////////////////////////

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: colors.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                BorderSide(color: colors.primary.withValues(alpha: 0.4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: colors.primary, width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
