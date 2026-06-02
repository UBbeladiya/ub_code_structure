import 'package:flutter/material.dart';

import 'app_loading_indicator.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? backgroundColor, textColor, disabledColor;
  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final bool isFontBold;
  final IconData? preFixIcon;
  final String? preFixImage;
  final double? alpha;

  const PrimaryButton(
      this.title, {
        this.width = 200,
        this.height = 44,
        this.onPressed,
        this.backgroundColor,
        this.isFontBold = false,
        this.isLoading = false,
        this.textColor,
        this.preFixIcon,
        this.preFixImage,
        this.disabledColor,
        this.alpha,
        super.key,
      });

  const PrimaryButton.infinity(
      this.title, {
        this.height = 44,
        this.onPressed,
        this.backgroundColor,
        this.isFontBold = false,
        this.isLoading = false,
        super.key,
        this.textColor,
        this.preFixIcon,
        this.preFixImage,
        this.disabledColor,
        this.alpha,
      }) : width = double.infinity;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;
    final colorScheme = Theme.of(context).colorScheme;
    final baseBackground = backgroundColor ?? colorScheme.primary;
    final baseForeground = textColor ?? colorScheme.onPrimary;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: baseBackground,
          foregroundColor: baseForeground,
          disabledBackgroundColor:
              disabledColor ?? baseBackground.withValues(alpha: alpha ?? 0.8),
          disabledForegroundColor: baseForeground.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height / 2)),
          padding: EdgeInsets.zero,
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading
            ? AppLoadingIndicator()
            : preFixIcon != null || preFixImage != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      if (preFixIcon != null) ...{
                        Icon(
                          preFixIcon,
                          color: baseForeground,
                        ),
                      },
                      if (preFixImage != null) ...{
                       /* SvgPicture.asset(
                          preFixImage ?? '',
                          errorBuilder: (_, _, _) => Image.asset(
                            preFixImage ?? '',
                            errorBuilder: (_, _, _) => const SizedBox.shrink(),
                          ),
                        ),*/
                      },
                      Text(
                        title,
                        textAlign: .center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isDisabled
                                  ? baseForeground.withValues(alpha: 0.5)
                                  : baseForeground,
                              fontWeight: isFontBold ? FontWeight.bold : null,
                            ),
                      ),
                    ],
                  )
                : Text(
                    title,
                    textAlign: .center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDisabled
                              ? baseForeground.withValues(alpha: 0.5)
                              : baseForeground,
                          fontWeight: isFontBold ? FontWeight.bold : null,
                        ),
                  ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final Color? textColor;
  final Color? outlineColor;

  const SecondaryButton(
      this.title, {
        super.key,
        this.width = 200,
        this.height = 44,
        this.onPressed,
        this.isLoading = false,
        this.textColor,
        this.outlineColor,
      });

  const SecondaryButton.infinity(
      this.title, {
        this.height = 44,
        this.onPressed,
        this.isLoading = false,
        this.textColor,
        this.outlineColor,
        super.key,
      }) : width = double.infinity;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;
    final colorScheme = Theme.of(context).colorScheme;
    final baseTextColor = textColor ?? colorScheme.primary;
    final baseOutlineColor = outlineColor ?? colorScheme.outline;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          alignment: .center,
          foregroundColor: baseTextColor,
          disabledForegroundColor: baseTextColor.withValues(alpha: 0.5),
          side: BorderSide(color: baseOutlineColor.withValues(alpha: isDisabled ? 0.5 : 1)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height / 2)),
          padding: EdgeInsets.zero,
          textStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading ? AppLoadingIndicator() : Text(title, textAlign: .center),
      ),
    );
  }
}

class TertiaryButtonIconStyle {
  final bool iconOnLeft;
  final IconData iconData;

  const TertiaryButtonIconStyle({
    this.iconData = Icons.chevron_left,
    this.iconOnLeft = true,
  });
}

class TertiaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final String title;
  final Color? textColor;

  final TertiaryButtonIconStyle? iconStyle;

  const TertiaryButton(
      this.title, {
        super.key,
        this.onPressed,
        this.padding,
        this.textColor,
        this.iconStyle,
      });

  @override
  Widget build(BuildContext context) {
    final color = onPressed != null
        ? (iconStyle != null ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onTertiary)
        : Theme.of(context).colorScheme.onTertiary.withValues(alpha: 0.5);
    final finalColor = textColor ?? color;

    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        foregroundColor: finalColor,
        disabledForegroundColor: Theme.of(context).colorScheme.onTertiary.withValues(alpha: 0.5),
        textStyle: Theme.of(context).textTheme.labelMedium,
      ),
      onPressed: onPressed,
      child: iconStyle != null
          ? Row(
        mainAxisAlignment: .center,
        spacing: 4,
        children: [
          if (iconStyle!.iconOnLeft) Icon(iconStyle!.iconData, color: finalColor),
          Text(title, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: finalColor)),
          if (!iconStyle!.iconOnLeft) Icon(iconStyle!.iconData, color: finalColor),
        ],
      )
          : Text(title),
    );
  }
}


class AppGestureIconButton extends StatelessWidget {
  const AppGestureIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconSize = 20,
    this.iconColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(10),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onTap != null;
    final resolvedIconColor = iconColor ?? colorScheme.onSurface;
    final resolvedBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerHighest;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: resolvedBackgroundColor,
            borderRadius: borderRadius,
          ),
          child: Icon(icon, size: iconSize, color: resolvedIconColor),
        ),
      ),
    );
  }
}
