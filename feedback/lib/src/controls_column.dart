// ignore_for_file: public_member_api_docs

import 'package:feedback/src/feedback_mode.dart';
import 'package:feedback/src/l18n/translation.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:flutter/material.dart';

/// This is the Widget on the right side of the app when the feedback view
/// is active.
class ControlsColumn extends StatelessWidget {
  /// Creates a [ControlsColumn].
  ControlsColumn({
    super.key,
    required this.mode,
    required this.activeColor,
    required this.onColorChanged,
    required this.onUndo,
    required this.onControlModeChanged,
    required this.onCloseFeedback,
    required this.onClearDrawing,
    required this.colors,
  })  : assert(
          colors.isNotEmpty,
          'There must be at least one color to draw in colors',
        ),
        assert(colors.contains(activeColor), 'colors must contain activeColor');

  final ValueChanged<Color> onColorChanged;
  final VoidCallback onUndo;
  final ValueChanged<FeedbackMode> onControlModeChanged;
  final VoidCallback onCloseFeedback;
  final VoidCallback onClearDrawing;
  final List<Color> colors;
  final Color activeColor;
  final FeedbackMode mode;

  @override
  Widget build(BuildContext context) {
    final isNavigatingActive = FeedbackMode.navigate == mode;
    final feedbackTheme = FeedbackTheme.of(context);
    final scheme = feedbackTheme.colorScheme;
    final isLight = scheme.brightness == Brightness.light;
    final iconColor =
        isLight ? const Color(0xFF1C1B1F) : const Color(0xFFF1EDF2);
    final mutedIconColor =
        isLight ? const Color(0xFF5A5A5A) : const Color(0xFFBDB7C4);
    final textStyle = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: iconColor);
    return Card(
      margin: EdgeInsets.zero,
      color: feedbackTheme.feedbackSheetColor,
      surfaceTintColor: feedbackTheme.feedbackSheetColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: IconTheme(
        data: IconThemeData(
          color: iconColor,
          opacity: 1.0,
        ),
        child: DefaultTextStyle(
          style: textStyle ?? const TextStyle(),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              IconButton(
                key: const ValueKey<String>('close_controls_column'),
                icon: const Icon(Icons.close),
                onPressed: onCloseFeedback,
              ),
              _ColumnDivider(),
              RotatedBox(
                quarterTurns: 1,
                child: MaterialButton(
                  key: const ValueKey<String>('navigate_button'),
                  textColor: iconColor,
                  onPressed: isNavigatingActive
                      ? null
                      : () => onControlModeChanged(FeedbackMode.navigate),
                  disabledTextColor:
                      FeedbackTheme.of(context).activeFeedbackModeColor,
                  child: Text(FeedbackLocalizations.of(context).navigate),
                ),
              ),
              _ColumnDivider(),
              RotatedBox(
                quarterTurns: 1,
                child: MaterialButton(
                  key: const ValueKey<String>('draw_button'),
                  minWidth: 20,
                  textColor: iconColor,
                  onPressed: isNavigatingActive
                      ? () => onControlModeChanged(FeedbackMode.draw)
                      : null,
                  disabledTextColor:
                      FeedbackTheme.of(context).activeFeedbackModeColor,
                  child: Text(FeedbackLocalizations.of(context).draw),
                ),
              ),
              IconButton(
                key: const ValueKey<String>('undo_button'),
                icon: const Icon(Icons.undo),
                color: iconColor,
                disabledColor: mutedIconColor,
                onPressed: isNavigatingActive ? null : onUndo,
              ),
              IconButton(
                key: const ValueKey<String>('clear_button'),
                icon: const Icon(Icons.delete),
                color: iconColor,
                disabledColor: mutedIconColor,
                onPressed: isNavigatingActive ? null : onClearDrawing,
              ),
              for (final color in colors)
                _ColorSelectionIconButton(
                  key: ValueKey<Color>(color),
                  color: color,
                  onPressed: isNavigatingActive ? null : onColorChanged,
                  isActive: activeColor == color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorSelectionIconButton extends StatelessWidget {
  const _ColorSelectionIconButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.isActive,
  });

  final Color color;
  final ValueChanged<Color>? onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isActive ? Icons.lens : Icons.panorama_fish_eye),
      color: color,
      disabledColor: color,
      onPressed: onPressed == null ? null : () => onPressed!(color),
    );
  }
}

class _ColumnDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 1,
      color: FeedbackTheme.of(context).colorScheme.outlineVariant,
    );
  }
}
