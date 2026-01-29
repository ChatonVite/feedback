# feedback_sentry

## Getting Started

Follow the setup instructions of [sentry_flutter](https://pub.dev/packages/sentry_flutter).

Then, you will need to add `feedback_sentry` to your `pubspec.yaml`.
The latest version is <a href="https://pub.dev/packages/feedback_sentry"><img src="https://img.shields.io/pub/v/feedback_sentry.svg" alt="pub.dev"></a>.

```yaml
dependencies:
  feedback_sentry: x.y.z # use the latest version found on pub.dev
```

Then, run `flutter pub get` in your terminal.

### Use it

Just wrap your app in a `BetterFeedback` widget.
To show the feedback view just call `BetterFeedback.of(context).show(...);`.
The callback gets called when the user submits his feedback. 

```dart
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    BetterFeedback(
      child: const MyApp(),
    ),
  );
}
```

Provide a way to show the feedback panel by calling 
```dart
import 'package:feedback_sentry/feedback_sentry.dart';

BetterFeedback.of(context).showAndUploadToSentry(
    name: 'Foo Bar', // optional
    email: 'foo_bar@example.com', // optional
);
```
Provide a way to hide the feedback panel by calling  `BetterFeedback.of(context).hide();` 

### Themed controls (updated API)

`showAndUploadToSentry` is a convenience method. If you need to customize
themes or controls for a single feedback session, call `show(...)` with
`sendToSentry(...)` and pass the new override parameters:

```dart
import 'package:feedback/feedback.dart';
import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/material.dart';

BetterFeedback.of(context).show(
  sendToSentry(
    name: 'Foo Bar',
    email: 'foo_bar@example.com',
  ),
  themeMode: ThemeMode.system,
  theme: FeedbackThemeData.light(),
  darkTheme: FeedbackThemeData.dark(),
  controlsTheme: const FeedbackControlsThemeData(
    iconColor: Colors.white,
    disabledIconColor: Colors.white54,
    dividerColor: Colors.white24,
    useColorEvenIfDisabled: true,
  ),
);
```

### Recent changes (3.2.0+chatonvite.darkmode.3)

- Document per-session theme/controls overrides when using `sendToSentry`.


## 📣  Author

- Jonas Uekötter: [GitHub](https://github.com/ueman) and [Twitter](https://twitter.com/ue_man)

## Issues, questions and contributing

You can raise issues [here](https://github.com/ueman/feedback/issues).
If you've got a question do not hesitate to ask it [here](https://github.com/ueman/feedback/discussions).
Contributions are also welcome. You can do a pull request on GitHub [here](https://github.com/ueman/feedback/pulls). Please take a look at [`up for grabs`](https://github.com/ueman/feedback/issues?q=is%3Aopen+is%3Aissue+label%3Aup-for-grabs) issues first.
