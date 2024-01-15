import 'package:flutter/material.dart';

import 'enums.dart';

class MediumButton extends StatelessWidget {
  const MediumButton({
    Key? key,
    this.iconSize,
    this.padding,
    this.enableButton = true,
    this.disabledColor,
    this.enableText = true,
    this.enableIcon = false,
    this.text,
    this.icon,
    this.textStyle,
    this.textColor,
    this.buttonColor,
    this.iconColor,
    this.iconLocation = IconLocation.beforeText,
    this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  final Color? disabledColor;
  final bool enableButton;
  final EdgeInsets? padding;
  final double? iconSize;

  /// Enables the icon on the button. Default value is false.
  ///
  /// `icon` property should not be null if enabled
  final bool enableIcon;

  /// Enables the text on the button. Default value is true.
  ///
  /// `text` property should not be null if enabled
  final bool enableText;

  final IconLocation iconLocation;
  final String? text;
  final IconData? icon;

  /// The color for the icon displayed on the button.
  ///
  /// `enableIcon` should be true and `icon` should be not null.
  final Color? iconColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? buttonColor;
  final GestureTapCallback onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 48),
      child: _FilledButton(
        iconSize: iconSize,
        enableButton: enableButton,
        disabledColor: disabledColor,
        onPressed: onPressed,
        borderRadius: borderRadius,
        padding: padding ?? const EdgeInsets.all(12),
        buttonColor: buttonColor,
        iconLocation: iconLocation,
        enableIcon: enableIcon,
        icon: icon,
        iconColor: iconColor,
        enableText: enableText,
        text: text,
        textStyle: textStyle,
        textColor: textColor,
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  _FilledButton({
    required this.enableButton,
    required this.disabledColor,
    required this.onPressed,
    required this.buttonColor,
    required this.iconLocation,
    required this.enableIcon,
    required this.icon,
    required this.iconColor,
    required this.enableText,
    required this.text,
    this.iconSize,
    this.textStyle,
    this.textColor,
    this.padding,
    this.borderRadius,
  })  : assert(
          !(enableIcon == false && enableText == false),
          throw Exception(
            'enableIcon and enableText properties cannot be false at same time',
          ),
        ),
        assert(
          enableIcon ? icon != null : true,
          throw Exception(
            'An icon should be assigned if enableIcon is true',
          ),
        ),
        assert(
          enableText ? text != null : true,
          throw Exception(
            'A text should be assigned if enableText is true',
          ),
        );

  final GestureTapCallback onPressed;
  final Color? buttonColor;
  final IconLocation iconLocation;
  final bool enableIcon;
  final IconData? icon;
  final Color? iconColor;
  final bool enableText;
  final String? text;
  final TextStyle? textStyle;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? disabledColor;
  final bool enableButton;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enableButton ? onPressed : null,
      color: buttonColor ?? Theme.of(context).colorScheme.primary,
      disabledColor: disabledColor ??
          buttonColor?.withOpacity(0.5) ??
          Theme.of(context).colorScheme.primary.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      padding: padding,
      minWidth: 0,
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: iconLocation == IconLocation.beforeText
              ? TextDirection.ltr
              : TextDirection.rtl,
          children: [
            if (enableIcon) ...[
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: iconSize ?? 22,
              ),
            ],
            if (enableIcon && enableText) ...[
              const VerticalDivider(color: Colors.transparent),
            ],
            if (enableText) ...[
              Text(
                text!,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: enableButton
                              ? textColor ?? Colors.white
                              : textColor?.withOpacity(0.5) ?? Colors.white,
                        ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
