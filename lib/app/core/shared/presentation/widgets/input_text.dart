import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    this.errorText,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.validator,
    this.initialValue,
    this.label,
    this.hint,
    this.isRequiredField = false,
    this.maxLength,
    this.maxLines,
    this.isEnabled = true,
    this.inputType,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.sufixIcon,
    this.isPassword = false,
    this.borderColor,
    this.textColor,
    this.labelColor,
    this.focusedBorderColor,
    this.sufixIconTap,
    this.prefixIconTap,
    this.isAutoFocus = false,
    this.isAutoCorrect = true,
    this.elevation,
    this.textInputAction = TextInputAction.done,
    this.borderRadius,
    this.borderWidth,
    this.inputFormatters,
    this.fillColor,
    this.textCapitalization,
    this.hasTopLabel,
    this.padding,
  }) : super(key: key);

  final String? errorText;
  final ValueChanged<String>? onChanged;
  final Function(String value)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String Function(String?)? validator;
  final String? initialValue;
  final String? label;
  final String? hint;
  final int? maxLength;
  final int? maxLines;
  final bool isEnabled;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final IconData? sufixIcon;
  final bool isPassword;
  final Color? borderColor;
  final Color? textColor;
  final Color? labelColor;
  final Color? focusedBorderColor;
  final GestureTapCallback? sufixIconTap;
  final GestureTapCallback? prefixIconTap;
  final bool isAutoFocus;
  final bool isAutoCorrect;
  final double? elevation;
  final TextInputAction textInputAction;
  final double? borderRadius;
  final double? borderWidth;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final TextCapitalization? textCapitalization;
  final bool? hasTopLabel;
  final EdgeInsets? padding;
  final bool isRequiredField;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: labelColor ?? Theme.of(context).colorScheme.secondary,
              ),
        ),
        SizedBox(height: label != null ? 8 : 0),
        TextFormField(
          key: key,
          maxLines: maxLines ?? 1,
          focusNode: focusNode,
          validator: validator,
          initialValue: initialValue,
          cursorColor: Colors.black54,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          autofocus: isAutoFocus,
          obscureText: isPassword,
          controller: controller,
          autocorrect: isAutoCorrect,
          maxLength: maxLength,
          textAlign: TextAlign.left,
          keyboardType: inputType,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          inputFormatters: inputFormatters,
          style: TextStyle(
            color: textColor ?? Colors.grey[700],
            fontWeight: FontWeight.w400,
          ),
          textInputAction: textInputAction,
          decoration: InputDecoration(
            alignLabelWithHint: hasTopLabel,
            counterText: '',
            errorStyle: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
            errorText: errorText,
            focusColor: errorText != null ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            suffixIcon: sufixIcon != null
                ? GestureDetector(
                    onTap: sufixIconTap,
                    child: Icon(
                      sufixIcon,
                      color: errorText != null ? Theme.of(context).colorScheme.error : null,
                    ),
                  )
                : null,
            prefixIcon: prefixIcon != null
                ? GestureDetector(
                    onTap: prefixIconTap,
                    child: Icon(
                      prefixIcon,
                      color: errorText != null ? Theme.of(context).colorScheme.error : null,
                    ),
                  )
                : isRequiredField
                    ? Icon(
                        UniconsLine.asterisk,
                        size: 12,
                        color: isEnabled ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.error.withOpacity(0.7),
                      )
                    : null,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: textColor ?? Colors.black54,
                  overflow: TextOverflow.ellipsis,
                ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                // style: BorderStyle.solid,
                // width: borderWidth != null ? borderWidth : 2,
                color: borderColor != null ? borderColor! : Colors.grey[300]!,
              ),
              borderRadius: borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius!)) : BorderRadius.zero,
            ),
            filled: true,
            fillColor: fillColor ?? Colors.white,
            contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth != null ? borderWidth! : 1,
                color: focusedBorderColor ?? Theme.of(context).colorScheme.primaryContainer,
              ),
              borderRadius: borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius!)) : const BorderRadius.all(Radius.circular(0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth != null ? borderWidth! : 1,
                color: borderColor ?? Theme.of(context).colorScheme.primaryContainer,
              ),
              borderRadius: borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius!)) : const BorderRadius.all(Radius.circular(0)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                width: borderWidth != null ? borderWidth! : 1,
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: borderRadius != null ? BorderRadius.all(Radius.circular(borderRadius!)) : const BorderRadius.all(Radius.circular(0)),
            ),
            enabled: isEnabled,
          ),
        ),
      ],
    );
  }
}
