import 'package:flutter/material.dart';

/// Centered loading indicator with optional message text.
class AppLoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator widget.
  const AppLoadingIndicator({super.key, this.message});

  /// Optional message displayed below the spinner.
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 12),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
