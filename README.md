# 🔖 Checklist App

This is a Flutter project that utilizes Fastlane and GitHub Actions for continuous integration and deployment (CI/CD) automation.

Fastlane is a command-line tool for automating common development tasks, such as building, testing, and deploying mobile apps. It allows us to define a series of steps that we want to automate as part of our development workflow, and then execute them with a single command. With Fastlane, we can automate the process of building, testing, and deploying our app, as well as many other common development tasks.

GitHub Actions is a powerful platform for automating workflows, including CI/CD pipelines. I have set up GitHub Actions to automatically  test and deploy the app to the stores when changes are made to the repository.

In addition to the code in this repository, I have also published two articles that explains how Fastlane and GitHub Actions was set up for this project. I hope that these articles will be helpful to other mobile app developers who are interested in streamlining their development workflows and improving the quality of their code.

[Flutter + Fastlane (Part 1)](https://o-ifeanyi.hashnode.dev/flutter-fastlane-part-1)

[Flutter + Fastlane + Actions (Part 2)](https://o-ifeanyi.hashnode.dev/flutter-fastlane-github-actions-part-2)

## ⬇️ Setting up locally 
- Clone the repo locally
- Navigate to the folder and run `flutter pub get` to install the required dart packages

## 📱 Running the application
Simply run `flutter run` command from the terminal

## 🧪 Running the test
Simply run `flutter run test` which would run both the unit and widget test

## 🤖 Running integration test
- Use the following command to run the integration test `flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart`

## 📸 Screenshots
| Light | Dark |
|------|-------|
|<img src="https://user-images.githubusercontent.com/60583263/233743953-001b6150-18e2-4a97-a4a0-06b12658c19f.png" width="400"> |  <img src="https://user-images.githubusercontent.com/60583263/233744004-2b5378ec-4e9b-424e-8b93-7bcdb6caed7c.png" width="400">|
|<img src="https://user-images.githubusercontent.com/60583263/233743985-545f9cea-d37c-4d59-ba6d-fef7e82ad5dd.png" width="400"> |  <img src="https://user-images.githubusercontent.com/60583263/233744027-243b72b4-0269-4d6f-9218-10ed63312186.png" width="400">|

## 🤓 Author(s)
[![Twitter Follow](https://img.shields.io/twitter/follow/onuoha_ifeanyi.svg?style=social)](https://twitter.com/onuoha_ifeanyi)

## 🔖 License
    Copyright 2023 Onuoha Ifeanyi

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
