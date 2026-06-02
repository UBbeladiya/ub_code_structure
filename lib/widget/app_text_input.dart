import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Cupertino-styled input field with Material-themed borders and validation UI.
class PrimaryTextField extends StatelessWidget {
  /// Placeholder text rendered when the field is empty.
  final String placeholder;

  /// Optional controller used to read/write the current value.
  final TextEditingController? controller;

  /// Keyboard type used by the platform IME.
  final TextInputType? keyboardType;

  /// Tap callback for the inner text field.
  final GestureTapCallback? onTap;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// Callback fired when editing completes.
  final VoidCallback? onEditingComplete;

  /// Whether this field is read-only.
  final bool readOnly;

  /// Whether entered text is obscured.
  final bool isObscure;

  /// Focus node used to control and observe focus state.
  final FocusNode? focusNode;

  /// Minimum number of visible lines.
  final int? minLines;

  /// Maximum number of visible lines.
  final int? maxLines;

  /// Border radius value for the container.
  final double? borderRadius;

  /// Validator used by the wrapping [FormField].
  final FormFieldValidator<String>? validator;

  /// Optional trailing widget rendered inside the text field.
  final Widget? trailing;

  /// Optional focused border color override.
  final Color? focusBorderColor;

  /// Optional focused border width override.
  final double? focusBorderWidth;

  /// Creates a configurable primary text field.
  const PrimaryTextField({
    super.key,
    required this.placeholder,
    this.controller,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.readOnly = false,
    this.focusNode,
    this.minLines,
    this.maxLines,
    this.validator,
    this.isObscure = false,
    this.trailing,
    this.borderRadius,
    this.focusBorderColor,
    this.focusBorderWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FormField<String>(
      validator: (_) => validator?.call(controller?.text),
      builder: (state) {
        final isFocused = focusNode?.hasFocus ?? false;
        final borderColor = state.hasError
            ? colorScheme.error
            : (isFocused
                ? (focusBorderColor ?? colorScheme.primary)
                : colorScheme.outline);
        final borderWidth =
            state.hasError ? 0.5 : (isFocused ? (focusBorderWidth ?? 1.5) : 0.5);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(borderRadius ?? 4),
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              child: CupertinoTextField.borderless(
                placeholder: placeholder,
                controller: controller,
                keyboardType: keyboardType,
                onTap: onTap,
                onChanged: (value) {
                  state.didChange(value);
                  onChanged?.call(value);
                },
                onEditingComplete: onEditingComplete,
                readOnly: readOnly,
                focusNode: focusNode,
                minLines: minLines,
                maxLines: maxLines,
                obscureText: isObscure,
                style: Theme.of(context).textTheme.bodySmall,
                placeholderStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                suffix: trailing,
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  state.errorText ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
