# Contributing to the project

## requirements

Packages:

- dart
- flutter
- fvm >= 3.0.0
- swiftformat
- ktlint
- Xcode >= 15.3 with Swift >= 5.10

```bash
dart pub global activate melos
dart pub global activate very_good_cli
dart pub global activate coverde
```

## important commands

```bash
# bootstrap the project, install dependencies, and link packages
melos bootstrap

# generate platform code
melos run generate:pigeon

# generate test mocks
melos run generate:mocks

# run tests
melos run test

# run sample app
melos run run:example -- -d sdk     # android
melos run run:example -- -d IPhone  # ios

# setup a clean local environment
./setup_environment.sh
```

## resources

### sourcepoint

- [sourcepoint ios SDK](https://github.com/SourcePointUSA/ios-cmp-app)
- [sourcepoint android SDK](https://github.com/SourcePointUSA/android-cmp-app)

### tooling

- [Flutter](https://flutter.dev/)
- [Flutter documentation](https://flutter.dev/docs)
- [using melos and very_good_cli](https://adityadroid.medium.com/flutter-at-scale-code-sharing-using-a-monorepo-a7a46c427141)
- [very good dev](https://vgv.dev)
- [melos](https://melos.invertase.dev)
- [example melos + pigeon repo: flutterfire](https://github.com/firebase/flutterfire/)
- [example pigeon + swift host and flutter api](https://gitlab.com/twilio-flutter/conversations/-/blob/master/ios/Classes/SwiftTwilioConversationsPlugin.swift)
