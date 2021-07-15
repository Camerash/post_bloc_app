# Post Bloc App

[![Build Status](https://travis-ci.com/Camerash/post_bloc_app.svg?branch=master)](https://travis-ci.com/Camerash/post_bloc_app)
[![codecov](https://codecov.io/gh/Camerash/post_bloc_app/branch/master/graph/badge.svg?token=1KJ54D8QR4)](https://codecov.io/gh/Camerash/post_bloc_app)

This application fetches posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com) and display in a long scrolling list.

It follows the BLoC architecture, which is officially recommended for writing Flutter applications.

This project's aim is to allow me to:
- Revisit Flutter dev
- Learn about BLoC hands on
- Implement localization using intl
- Write test cases that aims for 100% code coverage, also integrates with codecov
- Refresh myself on CI/CD for Flutter
- Run tests and build artifacts on Travis CI

Following examples [here](https://bloclibrary.dev/#/flutterweathertutorial) and [here](https://bloclibrary.dev/#/flutterinfinitelisttutorial)

Useful reads:
- BLoC
  - [BLoC Library](https://bloclibrary.dev/#/gettingstarted)
- Localization
  - [Official tutorial](https://flutter.dev/docs/development/accessibility-and-localization/internationalization#introduction-to-localizations-in-flutter) and [package README](https://pub.dev/packages/intl)
  - [intl package config](https://docs.google.com/document/d/10e0saTfAv32OZLRmONy866vnaw0I2jwL8zukykpgWBc/edit#heading=h.upij01jgi58m)
  - [Flutter intl IDE plugin by Localizely](https://plugins.jetbrains.com/plugin/13666-flutter-intl)
- Tests
  - [Official tutorial](https://flutter.dev/docs/testing)
  - [Mocktail](https://pub.dev/packages/mocktail)
- CI/CD
  - [Travis CI](https://docs.travis-ci.com/user/tutorial/)
  - [Some medium ref](https://itnext.io/configuring-travis-ci-and-coveralls-with-flutter-4c65edfc42d3)
  - [Travis example for running integration tests](https://github.com/Backendless/Flutter-SDK/blob/master/.travis.yml)