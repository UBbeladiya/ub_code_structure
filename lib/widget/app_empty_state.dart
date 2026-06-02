import 'package:flutter/material.dart';

/// Reusable placeholder shown when there is no data to display.
class AppEmptyState extends StatelessWidget {
  /// Creates an empty-state view with optional icon and action.
  const AppEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  /// Main descriptive message.
  final String message;

  /// Icon rendered above the message.
  final IconData icon;

  /// Optional action widget shown below the message.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(message, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color)),
          if (action != null) ...[
            const SizedBox(height: 12),
            action!,
          ],
        ],
      ),
    );
  }
}
