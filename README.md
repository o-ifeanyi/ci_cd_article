# Checklist App

This is project built to consume the [checklist_api](https://github.com/o-ifeanyi/checklist/tree/master/checklist_api)

### Environment setup
This is a Flutter application and requires you have flutter installed on your computer. 

### Flutter installation
You should follow the [Flutter installation guide here](https://flutter.dev/docs/get-started/install)

### Setting up locally 
- Clone the repo locally
- Navigate to the folder and run `flutter pub get` to install the required dart packages

### Running the application
Simply run `flutter run` command from the terminal

### Running the test
Simply run `flutter run test` which would run both the unit and widget test

### Running integration test
- Use the following command to run the integration test `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart`

NB: You should already have an emulator running

- To run the integration test on a physical device (android), navigate to the android folder in the project `cd android` and run `gradlew app:connectedAndroidTest -Ptarget=`pwd`/../integration_test/app_test.dart`

NB: running on a physical android device needs to be done from android studio