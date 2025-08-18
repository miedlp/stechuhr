# Simple Stechuhr App

This is a simple app to track times, like a good old-fashioned Stechuhr.

## Features

The project serves as a first trial to use Flutter with a Rust backend and is not intended for to be developed into feature rich application, but is planned to be (and stay) limited to following features:

- [x] Show the current time on the home screen
- [ ] Record time and date when the "Start" and "Stop" buttons are pressed
- [ ] When the "Start" button is pressed, it should be disabled and the "Start" button should be activated to avoid consecutive "Start"-stamps. The same vice-versa for the "Stop" button.
- [ ] The table on the home page should show the recorded times for the selected date and the sum of the recorded time for that day, the week and the month.
- [ ] It is possible to set a weekly time goal and the diff to the goal is displayed on the main page.
- [ ] All the timestamps should be synced to Google Drive. There is a settings button to configure the Google Drive sync.

## Target Platforms

* Native Linux for rapid prototyping and debugging
* Android Phones for actual usage

## Repository structure

```bash
.
├── LICENSE
├── README.md
├── Cargo.toml
├── pubspec.yaml
├── analysis_options.yaml
├── devtools_options.yaml
├── flutter_rust_bridge.yaml
├── android/                            # Android specific code
│   └── ...
├── linux/                              # Linux specific code
│   └── ...
├── rust/                               # Rust backend source files
│   ├── Cargo.lock
│   ├── Cargo.toml
│   └── src
│       ├── api
│       │   └── ...
│       └── ...
├── integration_test
│   └── ...
├── rust_builder
│   └── ...
├── lib/
│   ├── main.dart
│   ├── pages/                          # Dart files defining the app pages
│   │   └── ...
│   ├── src
│   │   └── rust                        # Flutter-Rust-API
│   │       └── ...
│   └── widgets/                        # Dart files defining single custom elements of a page, i.e., custom widgets
│       └── ...
├── test
│   └── ...
├── test_driver
│    └── ...
└── ...
```
