// ignore_for_file: public_member_api_docs

import 'package:feedback/src/feedback_mode.dart';
import 'package:feedback/src/l18n/translation.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:flutter/material.dart';

/// This is the Widget on the right side of the app when the feedback view
/// is active.
typedef ControlsColumnBuilder = Widget Function(
  BuildContext context, {
  required FeedbackMode mode,
  required bool isNavigatingActive,
  required FeedbackThemeData feedbackTheme,
  required Color activeColor,
  required List<Color> colors,
  required ValueChanged<Color> onColorChanged,
  required VoidCallback onUndo,
  required ValueChanged<FeedbackMode> onControlModeChanged,
  required VoidCallback onCloseFeedback,
  required VoidCallback onClearDrawing,
});

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
    final controlsTheme = feedbackTheme.controlsTheme;
    final TextStyle? buttonTextStyle = controlsTheme?.textStyle;
    final Color? iconColor = controlsTheme?.iconColor;
    final Color? disabledIconColor = controlsTheme?.disabledIconColor;
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
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          IconButton(
            key: const ValueKey<String>('close_controls_column'),
            icon: const Icon(Icons.close),
            color: iconColor,
            disabledColor: disabledIconColor,
            onPressed: onCloseFeedback,
          ),
          _ColumnDivider(color: controlsTheme?.dividerColor),
          RotatedBox(
            quarterTurns: 1,
            child: MaterialButton(
              key: const ValueKey<String>('navigate_button'),
              onPressed: isNavigatingActive
                  ? null
                  : () => onControlModeChanged(FeedbackMode.navigate),
              disabledTextColor:
                  controlsTheme?.disabledIconColor ??
                      FeedbackTheme.of(context).activeFeedbackModeColor,
              child: Text(
                FeedbackLocalizations.of(context).navigate,
                style: buttonTextStyle,
              ),
            ),
          ),
          _ColumnDivider(color: controlsTheme?.dividerColor),
          RotatedBox(
            quarterTurns: 1,
            child: MaterialButton(
              key: const ValueKey<String>('draw_button'),
              minWidth: 20,
              onPressed: isNavigatingActive
                  ? () => onControlModeChanged(FeedbackMode.draw)
                  : null,
              disabledTextColor:
                  controlsTheme?.disabledIconColor ??
                      FeedbackTheme.of(context).activeFeedbackModeColor,
              child: Text(
                FeedbackLocalizations.of(context).draw,
                style: buttonTextStyle,
              ),
            ),
          ),
          IconButton(
            key: const ValueKey<String>('undo_button'),
            icon: const Icon(Icons.undo),
            color: iconColor,
            disabledColor: disabledIconColor,
            onPressed: isNavigatingActive ? null : onUndo,
          ),
          IconButton(
            key: const ValueKey<String>('clear_button'),
            icon: const Icon(Icons.delete),
            color: iconColor,
            disabledColor: disabledIconColor,
            onPressed: isNavigatingActive ? null : onClearDrawing,
          ),
          for (final color in colors)
            _ColorSelectionIconButton(
              key: ValueKey<Color>(color),
              color: color,
              onPressed: isNavigatingActive ? null : onColorChanged,
              isActive: activeColor == color,
              disabledColor: disabledIconColor,
              colorPickerDisabledColor:
                  controlsTheme?.colorPickerDisabledColor,
              useColorEvenIfDisabled:
                  controlsTheme?.useColorEvenIfDisabled ?? false,
            ),
        ],
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
    required this.useColorEvenIfDisabled,
    required this.colorPickerDisabledColor,
    required this.disabledColor,
  });

  final Color color;
  final ValueChanged<Color>? onPressed;
  final bool isActive;
  final bool useColorEvenIfDisabled;
  final Color? colorPickerDisabledColor;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final Color? effectiveDisabledColor = colorPickerDisabledColor ??
        (useColorEvenIfDisabled ? color : disabledColor);
    return IconButton(
      icon: Icon(isActive ? Icons.lens : Icons.panorama_fish_eye),
      color: color,
      disabledColor: effectiveDisabledColor,
      onPressed: onPressed == null ? null : () => onPressed!(color),
    );
  }
}

class _ColumnDivider extends StatelessWidget {
  const _ColumnDivider({this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 1,
      color: color ?? Theme.of(context).dividerColor,
    );
  }
}
