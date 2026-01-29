import 'package:feedback/src/feedback_controller.dart';
import 'package:feedback/src/theme/feedback_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeedbackController', () {
    test(' default is hidden', () {
      final controller = FeedbackController();
      expect(controller.isVisible, false);
    });

    test(' change visibility from hidden to visible', () {
      final controller = FeedbackController();
      var listenerWasCalled = false;
      controller.addListener(() {
        listenerWasCalled = true;
      });

      controller.show((_) {});
      expect(controller.isVisible, true);
      expect(listenerWasCalled, true);
    });

    test(' change visibility from visible to hidden', () {
      final controller = FeedbackController();
      controller.show((_) {});
      var listenerWasCalled = false;
      controller.addListener(() {
        listenerWasCalled = true;
      });

      controller.hide();
      expect(controller.isVisible, false);
      expect(listenerWasCalled, true);
    });

    test(' show can set theme overrides', () {
      final controller = FeedbackController();
      final theme = FeedbackThemeData.light();
      final darkTheme = FeedbackThemeData.dark();

      controller.show(
        (_) {},
        themeMode: ThemeMode.dark,
        theme: theme,
        darkTheme: darkTheme,
      );

      expect(controller.themeModeOverride, ThemeMode.dark);
      expect(controller.themeOverride, theme);
      expect(controller.darkThemeOverride, darkTheme);
    });

    test(' hide clears theme overrides', () {
      final controller = FeedbackController();
      controller.show(
        (_) {},
        themeMode: ThemeMode.dark,
        theme: FeedbackThemeData.light(),
        darkTheme: FeedbackThemeData.dark(),
      );

      controller.hide();
      expect(controller.themeModeOverride, null);
      expect(controller.themeOverride, null);
      expect(controller.darkThemeOverride, null);
    });
  });
}
