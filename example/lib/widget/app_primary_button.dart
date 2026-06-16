import 'package:flutter/material.dart';

import 'app_loading_indicator.dart';

/// Primary filled action button used for high-emphasis actions.
class PrimaryButton extends StatelessWidget {
  /// Target width of the button.
  final double width;

  /// Target height of the button.
  final double height;

  /// Optional override for filled background color.
  final Color? backgroundColor, textColor, disabledColor;

  /// Callback invoked when the button is tapped.
  final VoidCallback? onPressed;

  /// Visible button label.
  final String title;

  /// Whether to show a loading spinner and disable tap actions.
  final bool isLoading;

  /// Whether to force bold title text.
  final bool isFontBold;

  /// Optional leading icon.
  final IconData? preFixIcon;

  /// Optional leading image path.
  final String? preFixImage;

  /// Opacity used for the disabled state.
  final double? alpha;

  /// Creates a fixed-size primary button.
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

  /// Creates a full-width primary button.
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

/// Outlined medium-emphasis button.
class SecondaryButton extends StatelessWidget {
  /// Target width of the button.
  final double width;

  /// Target height of the button.
  final double height;

  /// Callback invoked when the button is tapped.
  final VoidCallback? onPressed;

  /// Visible button label.
  final String title;

  /// Whether to show a loading spinner and disable tap actions.
  final bool isLoading;

  /// Optional override for text color.
  final Color? textColor;

  /// Optional override for border color.
  final Color? outlineColor;

  /// Creates a fixed-size secondary button.
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

  /// Creates a full-width secondary button.
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

/// Icon style metadata used by [TertiaryButton].
class TertiaryButtonIconStyle {
  /// Whether the icon should be rendered before the title text.
  final bool iconOnLeft;

  /// Icon glyph rendered beside the title.
  final IconData iconData;

  /// Creates icon style options for a tertiary button.
  const TertiaryButtonIconStyle({
    this.iconData = Icons.chevron_left,
    this.iconOnLeft = true,
  });
}

/// Low-emphasis text button optionally paired with an icon.
class TertiaryButton extends StatelessWidget {
  /// Callback invoked when the button is tapped.
  final VoidCallback? onPressed;

  /// Internal button padding.
  final EdgeInsets? padding;

  /// Visible button label.
  final String title;

  /// Optional override for foreground text/icon color.
  final Color? textColor;

  /// Optional icon style for rendering an icon with text.
  final TertiaryButtonIconStyle? iconStyle;

  /// Creates a tertiary text button.
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

/// Tappable icon button built with a gesture detector and custom decoration.
class AppGestureIconButton extends StatelessWidget {
  /// Creates an icon-only action button.
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

  /// Icon glyph to render.
  final IconData icon;

  /// Callback fired when the widget is tapped.
  final VoidCallback? onTap;

  /// Icon visual size.
  final double iconSize;

  /// Optional icon color override.
  final Color? iconColor;

  /// Optional background color override.
  final Color? backgroundColor;

  /// Internal content padding.
  final EdgeInsetsGeometry padding;

  /// Corner radius of the background container.
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
