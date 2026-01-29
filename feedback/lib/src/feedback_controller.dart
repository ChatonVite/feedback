import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

/// Controls the state of the feeback ui.
class FeedbackController extends ChangeNotifier {
  bool _isVisible = false;

  /// Whether the feedback ui is currently visible.
  bool get isVisible => _isVisible;

  /// This function is called when the user submits his feedback.
  OnFeedbackCallback? onFeedback;

  /// Optional theme overrides for the current feedback session.
  ThemeMode? _themeModeOverride;
  FeedbackThemeData? _themeOverride;
  FeedbackThemeData? _darkThemeOverride;

  /// The overridden theme mode for the active feedback session.
  ThemeMode? get themeModeOverride => _themeModeOverride;

  /// The overridden light theme for the active feedback session.
  FeedbackThemeData? get themeOverride => _themeOverride;

  /// The overridden dark theme for the active feedback session.
  FeedbackThemeData? get darkThemeOverride => _darkThemeOverride;

  /// Open the feedback ui.
  /// After the user submitted his feedback [onFeedback] is called.
  /// If the user aborts the process of giving feedback, [onFeedback] is
  /// not called.
  ///
  /// Use [themeMode], [theme], or [darkTheme] to override the feedback UI
  /// appearance for this feedback session only.
  void show(
    OnFeedbackCallback onFeedback, {
    ThemeMode? themeMode,
    FeedbackThemeData? theme,
    FeedbackThemeData? darkTheme,
  }) {
    _isVisible = true;
    this.onFeedback = onFeedback;
    _themeModeOverride = themeMode;
    _themeOverride = theme;
    _darkThemeOverride = darkTheme;
    notifyListeners();
  }

  /// Hides the feedback ui.
  /// Typically, this does not need to be called by the user of this library
  void hide() {
    _isVisible = false;
    _themeModeOverride = null;
    _themeOverride = null;
    _darkThemeOverride = null;
    notifyListeners();
  }

  /// The draggable scrollable sheet controller used by better feedback.
  ///
  /// The controller is only attached if [FeedbackThemeData.sheetIsDraggable] is
  /// true and feedback is currently displayed.
  final DraggableScrollableController sheetController =
      DraggableScrollableController();
}
