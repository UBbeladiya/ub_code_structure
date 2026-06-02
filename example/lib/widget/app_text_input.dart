import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PrimaryTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  //
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final bool readOnly;
  final bool isObscure;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final double? borderRadius;
  final FormFieldValidator<String>? validator;
  final Widget? trailing;
  final Color? focusBorderColor;
  final double? focusBorderWidth;

  const PrimaryTextField({
    super.key,
    required this.placeholder,
    this.controller,
    this.keyboardType,
    //
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
