import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? textInputType;
  final Icon? customprefixicon;
  final TextEditingController? textEditingController;
  final bool? customobscuretext;
  final String? Function(String? value)? validationfunction;
  final Icon? customsuffixIcon;
  final TextCapitalization? textCapitalization;
  final String? labelText;
  final InputBorder? border;
  final Function(String)? onFieldSubmitted;
  final InputBorder? focusedBorder;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool? obscureText;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;
  final int? minLines;
  final int? maxLines;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.textInputType,
      this.customprefixicon,
      this.onFieldSubmitted,
      this.textEditingController,
      this.customobscuretext,
      this.validationfunction,
      this.customsuffixIcon,
      this.textCapitalization,
      this.border,
      this.focusedBorder,
      this.prefixIcon,
      this.suffixIcon,
      this.contentPadding,
      this.hintStyle,
      this.suffixIconConstraints,
      this.prefixIconConstraints,
      this.onTap,
      this.obscureText,
      this.textInputAction,
      this.minLines,
      this.maxLines,
      this.onEditingComplete,
      this.inputFormatters,
      this.onChanged,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      textCapitalization: textCapitalization!,
      textInputAction: textInputAction ?? TextInputAction.next,
      autocorrect: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,
      style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 16),
      enableInteractiveSelection: true,
      cursorColor: Theme.of(context).primaryColorDark,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        prefixIconConstraints: prefixIconConstraints,
        border: border ??
            OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.24),
                    width: 1),
                borderRadius: BorderRadius.circular(8)),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark, width: 1),
                borderRadius: BorderRadius.circular(8)),
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: contentPadding,
      ),
      validator: validationfunction,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
