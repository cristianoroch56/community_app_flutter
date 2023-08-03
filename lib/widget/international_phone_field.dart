import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class Internationalphonefield extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialCountryCode;
  final String? hintText;
  final String? initialValue;
  final TextStyle? hintStyle;
  final bool? isDiaplayError;
  final Function(PhoneNumber)? onChanged;
  final Function(Country)? onCountryChanged;
  final InputBorder? border, enabledBorder, errorBorder;
  final InputBorder? focusedBorder;
  final EdgeInsets? flagsButtonMargin;
  final TextInputAction? textInputAction;
  final String? Function(PhoneNumber?)? validator;
  const Internationalphonefield(
      {super.key,
      this.controller,
      this.initialCountryCode,
      this.onChanged,
      this.onCountryChanged,
      this.border,
      this.initialValue,
      this.hintText,
      this.hintStyle,
      this.focusedBorder,
      this.flagsButtonMargin,
      this.textInputAction,
      this.validator,
      this.isDiaplayError = false,
      this.enabledBorder,
      this.errorBorder});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      flagsButtonMargin: flagsButtonMargin ?? const EdgeInsets.all(0),
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      dropdownIcon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).primaryColorDark,
      ),
      dropdownIconPosition: IconPosition.trailing,
      disableLengthCheck: false,
      cursorColor: Theme.of(context).primaryColorDark,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        counter: const SizedBox.shrink(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        hintStyle: hintStyle,
        focusedBorder: focusedBorder ??
            (isDiaplayError == true
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(8))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                        width: 1),
                    borderRadius: BorderRadius.circular(8),
                  )),
        enabledBorder: enabledBorder ??
            (isDiaplayError == true
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(8))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                        width: 1),
                    borderRadius: BorderRadius.circular(8),
                  )),
        errorBorder: errorBorder ??
            (isDiaplayError == true
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(8))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                        width: 1),
                    borderRadius: BorderRadius.circular(8),
                  )),
        border: border ??
            (isDiaplayError == true
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.red.shade800, width: 1),
                    borderRadius: BorderRadius.circular(8))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                        width: 1),
                    borderRadius: BorderRadius.circular(8),
                  )),
      ),
      initialCountryCode: initialCountryCode,
      initialValue: initialValue,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
    );
  }
}
